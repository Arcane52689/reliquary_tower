angular.module('AppControllers').controller('ColorSelectCtrl', ['Selected', '$scope', function(Selected, $scope) {

  this.initialize = function() {
    this.colors = Selected.colors;
    this.list = Selected.color_list;

  }

  this.toggle = function(color) {
    if (this.colors[color] === 'neutral') {
      this.colors[color] = 'selected';
    } else if (this.colors[color] === 'selected') {
      this.colors[color] = 'not-selected';
    } else {
      this.colors[color] = 'neutral';
    }
    $scope.$emit('ColorSelect')
  }


  this.checkClass = function(color) {
    return this.colors[color]
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







  this.initialize();
}]);
