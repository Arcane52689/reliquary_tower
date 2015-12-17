angular.module("AppControllers").controller("CategorySelectCtrl", ['Categories', '$scope', function(Categories, $scope) {
  this.initialize = function() {
    this.list = Categories;
    this.taggable = $scope.taggable;
    this.list.fetch({success: this.eliminateSelected.bind(this)})
    this.eliminateSelected();
    this.name = "";
  }

  this.eliminateSelected = function() {
    // var taggings = this.taggable.taggings.map(function(tagging) {
    //   return tagging.get('category_id');
    // })
    var taggings = [];
    this.list = Categories.where(function(cat) {
      return (taggings.indexOf(cat.id) < 0);
    });
  }

  this.updateDisplayed = function() {

    this.display = true
    var name = this.name.toLowerCase(), lowerName;
    this.displayed = this.list.where(function(category) {
      lowerName = category.get('name').toLowerCase();
      return (lowerName.indexOf(name) > -1);
    })
  }

  this.hideResults = function() {
    this.display = false;
  }

  this.select = function(category) {
    this.display = false
    this.name = category.get('name');
    this.selectedCategory = category;
  }

  this.addTag = function() {
    this.taggable.addTaging(category.id);
  }

  this.initialize();

}])
