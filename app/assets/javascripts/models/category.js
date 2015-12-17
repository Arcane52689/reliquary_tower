angular.module('AppModels').factory('Category', ['BaseModel', function(BaseModel) {
  var Category = function(data) {
    this.url = ""
    this.initialize(data);
  }

  BaseModel.parentOf(Category);
  return Category;
}])
