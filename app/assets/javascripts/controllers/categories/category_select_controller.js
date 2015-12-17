angular.module("AppControllers").controller("CategorySelectCtrl", ['Categories', '$scope', 'Flash', function(Categories, $scope, Flash) {
  this.initialize = function() {
    this.list = Categories;
    this.taggable = $scope.taggable;
    this.list.fetch({success: this.eliminateSelected.bind(this)})
    this.eliminateSelected();
    this.name = "";
  }

  this.eliminateSelected = function() {
    var taggings = this.taggable.attributes.category_ids;
    this.list = Categories.where(function(cat) {
      return (taggings.indexOf(cat.id) < 0);
    });
  }

  this.updateDisplayed = function() {
    this.selectedCategory = undefined;
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

  this.addSelected = function() {
    if (this.selectedCategory) {
      this.taggable.attributes.category_ids.push(this.selectedCategory.id);
      this.eliminateSelected();
      this.name = "";
    } else  {
      var newCat = Categories.addModel({name: this.name});
      newCat.save({
        success: function() {
          Flash.success(this.name + " was successfully created");
          this.taggable.attributes.category_ids.push(newCat.id);
          this.eliminateSelected();
          this.name = ""
        }.bind(this),
        error: function(resp) {
          Flash.error(resp.errors)
          newCat.removeFromCollections();
        }
      })
    }
  }

  this.initialize();

}])
