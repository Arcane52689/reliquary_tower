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

    $scope.$watch(function() {
      return this.deck.card_slots.models.length
    }.bind(this), this.updateRemainingCards.bind(this))

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
    this.deck.attributes.format = this.format.format || '';

    this.deck.save();
  }

  this.selectFormat = function() {
    this.formats.forEach(function(format) {
      if (format.format === this.deck.attributes.format) {
        this.format = format;
      }
    }.bind(this))
  }

  this.updateRemainingCards = function() {
    if (!this.format) {
      return
    }
    this.remainingCards = {
      'main deck': this.format.card_minimum - this.deck.totalInLocation('main deck')
    }
  }


  this.initialize();
}])
