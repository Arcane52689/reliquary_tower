;angular.module('AppUtilities').factory('Displayed', [function() {

  var Displayed = {
    popups: {
      cardView: false,
      loginView: false
    },

    keysIn: function(views) {
      var result = [];
      for (key in this[views]) {
        if (this[views].hasOwnProperty(key)) {
          result.push(key);
        }
      }
      return result;
    },

    hasActiveView: function(views) {
      var keys = this.keysIn(views);
      var active = false;
      keys.forEach(function(k) {

        if (this[views][k]) {
          active = true;
        }
      }.bind(this));
      console.log(active)
      return active;
    }



  }


  return Displayed;

}]);
