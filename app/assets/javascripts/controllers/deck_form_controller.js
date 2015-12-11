angular.module('AppControllers').controller("DeckFormCtrl", ['Deck', '$routeParams', function(Deck, $routeParams) {

  this.initialize = function() {
    this._createDeck();
  }



  this._createDeck = function() {
    if($routeParams['id']) {
      this.deck = new Deck({id: $routeParams['id']})
      this.deck.fetch();
    } else {
      this.deck = new Deck()
    }
  }

  this.card_slots = function() {
    return this.deck.card_slots();
  }

  this.addSlot = function() {
    this.deck.addBlankSlot({location: 'main deck'})
  }


  this.initialize();
}])
