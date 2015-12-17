angular.module("AppControllers").controller("TaggingCtrl", [ 'Categories', '$scope', function(Categories, $scope) {
  this.initialize = function() {
    this.category = Categories.find($scope.categoryId);
    this.taggable = $scope.taggable;
  }

  this.remove = function() {
    var index = this.taggable.attributes.category_ids.indexOf(this.category.id);
    this.taggable.attributes.category_ids.splice(index, 1);
  }




  this.initialize();
}])
