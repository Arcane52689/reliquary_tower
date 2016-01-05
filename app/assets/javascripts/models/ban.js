;angular.module('AppModels').factory('Ban', ['BaseModel', function(BaseModel) {
  var Ban = function(data) {
    this.urlBase = "api/bans";
    this.initialize(data);
  }

  BaseModel.parentOf(Ban)

  Ban.prototype.toJSON = function() {
    data = {"ban": this.attributes}
    data.namespace = "ban"
    return data;
  }



  return Ban;
}]);
