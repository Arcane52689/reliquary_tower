;angular.module('AppModels').factory('CardSlot', ['BaseModel', 'Card', function(BaseModel, Card) {
  var CardSlot = function(data) {
    this.initialize(data);
    this.urlBase = "";
    this.card = new Card();
  }

  BaseModel.parentOf(CardSlot);

  CardSlot.prototype.updateAttributes = function(data) {
    data = data || {};
    if (data.card) {
      this.card.updateAttributes(data.card);
      delete data.card
    }
    BaseModel.prototype.updateAttributes.call(this, data);
  }



  return CardSlot

}]);
