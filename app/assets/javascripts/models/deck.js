;angular.module('AppModels').factory('Deck', ['BaseModel', 'BaseCollection', 'CardSlot', function(BaseModel, BaseCollection, CardSlot) {
  var Deck = function(data) {
    this.initialize(data);
    this.urlBase = "api/decks"
    this.card_slots = new BaseCollection({
      model: CardSlot
    })
  }

  BaseModel.parentOf(Deck);

  Deck.prototype.updateAttributes = function(data) {
    if (data.card_slots) {

    }

  }




  return Deck;
}]);
