angular.module('AppControllers').controller("DeckFormCtrl", ['Deck', '$routeParams', function(Deck, $routeParams) {

  this.initialize = function() {
    this._createDeck();
  }



  this._createDeck = function() {
    if($routeParams['id']) {
      this.deck = new Deck({id: $routeParams['id']})
      this.loading = true
      this.deck.fetch({
        success: function() {
          this.loading = false;
        }.bind(this)
      });
    } else {
      this.loading = false
      this.deck = new Deck()
    }
  }

  this.card_slots = function() {
    return this.deck.card_slots();
  }

  this.addSlot = function(location) {
    this.deck.addBlankSlot({location: location})
  }


  this.save = function() {
    this.deck.card_slots.where(function(slot) {
      return((!slot.card_id) || (slot.quantity < 1))
    }).each(function(slot) {
      slot.removeFromCollections();
    });
    this.deck.save();
  }

  this.initialize();
}])
