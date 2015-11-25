angular.module("AppDirectives").directive('colorSelect', function() {
  return {
    restrict: 'E',
    replace: 'true',
    controller: 'ColorSelectCtrl',
    controllerAs: 'colors',
    templateUrl: 'color_select.html'
  }
})
