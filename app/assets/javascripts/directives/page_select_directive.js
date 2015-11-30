angular.module('AppDirectives').directive('pageSelect', function() {
  return {
    restrict: 'E',
    replace: true,
    templateUrl: 'page_select.html',
    controller: 'PageSelectCtrl',
    controllerAs: 'pageSelect'
  }
})
