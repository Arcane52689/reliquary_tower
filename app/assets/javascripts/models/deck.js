;angular.module('AppModels').factory('Deck', ['BaseModel', function(BaseModel) {
  var Deck = function(data) {
    this.initialize(data);
    this.urlBase = "api/decks"
  }

  BaseModel.parentOf(Deck);

  return Deck;
}]);
