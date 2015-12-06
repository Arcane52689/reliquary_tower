angular.module('AppDirectives').directive('myHeader', function() {
  return {
    replace: true,
    restrict: 'E',
    templateUrl: 'static/header.html',
    controller: 'HeaderCtrl',
    controllerAs: 'header'
  }
})
