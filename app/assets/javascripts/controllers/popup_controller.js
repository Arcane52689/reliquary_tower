angular.module('AppControllers').controller('PopupCtrl', ['Displayed', function(Displayed) {
  this.initialize = function() {
    this.dipslayed = Displayed.popups;
  }


  this.initialize();
}])
