;angular.module('AppModels').factory('CardSlot', ['BaseModel', 'Card', function(BaseModel, Card) {
  var CardSlot = function(data) {
    this.card = new Card();
    this.urlBase = "";
    this.initialize(data);
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

  CardSlot.prototype.toJSON = function() {
    this.attributes.card_id = this.card.id;
    return {};
  }



  return CardSlot

}]);
