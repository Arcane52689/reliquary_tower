angular.module('AppModels').factory('Category', ['BaseModel', function(BaseModel) {
  var Categroy = function() {
    this.initialize();
    this.url = ""
  }

  BaseModel.parentOf(Category);
  return Category;
}])
