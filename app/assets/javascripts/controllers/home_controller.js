angular.module('AppControllers').controller('HomeCtrl', ['CurrentUser', function(CurrentUser) {
  this.user = CurrentUser


  this.logout = function() {
    debugger
    this.user.logout();
  }

}])
