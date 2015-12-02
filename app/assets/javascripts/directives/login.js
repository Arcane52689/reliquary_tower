angular.module("AppDirectives").directive("login", function() {
  return {
    restrict: 'E',
    templateUrl: 'login.html',
    replace: true,
    controller: 'LoginCtrl',
    controllerAs: 'login'
  }
}
