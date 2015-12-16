angular.module('AppControllers').controller('PopupCtrl', ['Displayed', '$rootScope', function(Displayed, $rootScope) {
  this.initialize = function() {
    this.active = false;
    this.switching = false;
    this.displayed = Displayed.popups
  }


  this.hasActiveView = function() {
    return Displayed.hasActiveView('popups')
  }

  this.closeAll = function() {
    debugger
    this.displayed.cardView = false;
    this.displayed.loginView = false;
  }




  this.initialize();
}])
