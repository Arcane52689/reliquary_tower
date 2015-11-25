angular.module('AppControllers').controller('ColorSelectCtrl', ['Selected', '$scope', function(Selected, $scope) {

  this.initialize = function() {
    this.colors = Selected.colors;
    this.list = Selected.color_list;

  }

  this.toggle = function(color) {
    this.colors[color] = this.colors[color] ? false :true;
    $scope.$emit('ColorSelect')
  }

  this.toggleStrict = function() {
    Selected.strict = Selected.strict ? false : true;
  }

  this.checkClass = function(color) {
    return this.isSelected(color);
  }

  this.grabImage = function(color) {
    var images = {
      Green: window.green_mana_url,
      Red: window.red_mana_url,
      Black: window.black_mana_url,
      Blue: window.blue_mana_url,
      White: window.white_mana_url
    }
    return images[color];
  }

  this.isStrict = function() {
    return Selected.strict;
  }

  this.isSelected = function(color) {
    if (this.colors[color]) {
      return " selected "
    } else {
      return ""
    }
  }



  this.initialize();
}]);
