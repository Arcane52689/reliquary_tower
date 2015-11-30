angular.module('AppControllers').controller('HomeCtrl', ['CurrentUser', function(CurrentUser) {
  this.user = CurrentUser
}])
