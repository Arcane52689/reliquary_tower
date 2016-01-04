;angular.module('AppModels').factory('CardSlot', ['BaseModel', 'Card', function(BaseModel, Card) {
  var CardSlot = function(data) {
    this.card = new Card();
    this.card.on('sync', function() {
      this.attributes.card_id = this.card.id
    }.bind(this));
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



  CardSlot.prototype.setCard = function(card) {
    this.attributes.card_id = card.id
    this.card = card;
  }


  return CardSlot

}]);
