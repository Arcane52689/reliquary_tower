;angular.module('AppModels').factory('CardSlot', ['BaseModel', 'Card', function(BaseModel, Card) {
  var CardSlot = function(data) {
    this.initialize(data);
    this.urlBase = "";
  }

  BaseModel.parentOf(CardSlot);

  CardSlot.prototype.updateAttributes = function(data) {
    data = data || {};
    if (data.card) {
      this.card = new Card(data.card);
      delete data.card
    }
    BaseModel.prototype.updateAttributes.call(this, data);
  }



  return CardSlot

}]);
