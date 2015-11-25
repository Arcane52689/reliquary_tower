angular.module('AppUtilities').factory('Selected', function() {
  var Selected = {
    color_list: ["White", "Blue", "Black", "Red", 'Green'],
    colors: {
      White: true,
      Blue: true,
      Black: true,
      Red: true,
      Green: true
    },
    strict: false,

    selectedColors: function() {
      var result = [];
      this.color_list.forEach(function(color) {
        if (this.colors[color]) {
          result.push(color);
        }
      }.bind(this))
      return result;
    },

    excludedColors: function() {
      var result = [];
      this.color_list.forEach(function(color) {
        if (!this.colors[color]) {
          result.push(color);
        }
      }.bind(this));
      return result;
    }

    




  }



  return Selected;
})
