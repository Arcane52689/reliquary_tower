angular.module('AppModels').factory('Card', ['BaseModel', function(BaseModel) {
  var Card = function(data) {
    this.initialize(data)
    this.urlBase = "api/cards"
  }

  BaseModel.parentOf(Card)

  return Card
}])
