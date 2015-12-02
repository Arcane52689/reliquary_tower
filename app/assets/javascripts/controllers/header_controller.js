;
angular.module('AppControllers').controller('HeaderCtrl', ['CurrentUser', function (CurrentUser) {
  this.initialize = function() {
    this.user = CurrentUser;
  }







  this.initialize();
}]);
