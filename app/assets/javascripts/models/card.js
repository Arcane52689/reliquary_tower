angular.module('AppModels').factory('Card', ['BaseModel', '$http', function(BaseModel, $http) {
  var Card = function(data) {
    this.initialize(data)
    this.urlBase = "api/cards"
  }

  BaseModel.parentOf(Card)


  Card.prototype.findByName = function(options) {

    options = options || {};
    $http.get("api/cards/find_by", {params: {name: this.get('name')}}).success(function(resp) {
      this.updateAttributes(resp)
      options.success && options.success(resp);
    }.bind(this)).error(function(resp) {
      options.error && options.error(resp)
    })
  }


  return Card
}])
