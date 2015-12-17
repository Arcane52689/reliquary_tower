angular.module('AppControllers').controller("DeckFormCtrl", ['Deck', '$routeParams', 'Selected', 'Categories', '$scope', function(Deck, $routeParams, Selected, Categories, $scope) {

  this.initialize = function() {
    this._createDeck();

    this.formats = [
      {
        format: 'Commander',
        card_minimum: 99,
        card_maximum: 99,
        sideboard_size: 10,
        has_commander: true
      },
      {
        format: 'Tiny Leaders',
        card_minimum: '49',
        card_maximum: '49',
        sideboard_size: 10,
        has_commander: true
      },
      {
        format: 'Standard',
        card_minimum: 60,
        card_maximum: window.Infinity,
        sideboard_size: 15,
        has_commander: false,
      },
      {
        format: 'Modern',
        card_minimum: 60,
        card_maximum: window.Infinity,
        sideboard_size: 15,
        has_commander: false
      }
    ];

    this.format = undefined;

  }


  this._addNewSlots = function() {
    this.addSlot('sideboard');
    this.addSlot('main deck');

  }

  this.hasCommander = function() {
    return this.format.hasCommander;
  }

  this.deckInfo = function() {
    return {
      colors: this.deck.colorIdentity(),
      commander: this.deck.commander()
    }
  }


  this._createDeck = function() {
    if($routeParams['id']) {
      this.deck = new Deck({id: $routeParams['id']})
      this.loading = true
      this.deck.fetch({
        success: function() {
          this.loading = false;
          this.selectFormat()
        }.bind(this)
      });
    } else {
      this.loading = false;
      this.deck = new Deck();
      this._addNewSlots();
    }
    Selected.objects.deck = this.deck;
  }

  this.card_slots = function() {
    return this.deck.card_slots();
  }

  this.addSlot = function(location) {
    this.deck.addBlankSlot({location: location})
  }


  this.save = function() {
    this.deck.attributes.format = this.format.format;
    this.deck.card_slots.where(function(slot) {
      return ((!slot.card.id) || (slot.attributes.quantity < 1))
    }).each(function(slot) {
      slot.removeFromCollections();
    });
    this.deck.save();
  }

  this.selectFormat = function() {
    this.formats.forEach(function(format) {
      if (format.format === this.deck.attributes.format) {
        this.format = format;
      }
    }.bind(this))
  }



  this.initialize();
}])
