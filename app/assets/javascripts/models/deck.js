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
      this.card_slots.addModels(data.card_slots);
      delete data.card_slots
    }
    BaseModel.prototype.updateAttributes.call(this, data);
  }

  Deck.prototype.toJSON = function() {
    var data = {};
    data.card_slots = this.card_slots.map(function(card_slot) {
      return card_slot._toJSON
    });
    return data
  }


  return Deck;
}]);
