angular.module('AppUtilities').factory('Selected', function() {
  var Selected = {
    color_list: ["White", "Blue", "Black", "Red", 'Green'],
    colors: {
      White: 'neutral',
      Blue: 'neutral',
      Black: 'neutral',
      Red: 'neutral',
      Green: 'neutral'
    },
    strict: false,

    pageInfo: {
      currentPage: 1
    },

    objects: {
      card: undefined
    },

    selectedColors: function() {
      var result = [];
      this.color_list.forEach(function(color) {
        if (this.colors[color] === 'selected') {
          result.push(color);
        }
      }.bind(this))
      return result;
    },

    excludedColors: function() {
      var result = [];
      this.color_list.forEach(function(color) {
        if (this.colors[color] === 'not-selected') {
          result.push(color);
        }
      }.bind(this));
      return result;
    }








  }



  return Selected;
})
