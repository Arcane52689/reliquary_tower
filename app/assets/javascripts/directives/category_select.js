angular.module('AppDirectives').directive('categorySelect', function() {
  return {
    restrict: 'E',
    replace: true,
    templateUrl: 'categories/category_select.html',
    controller: 'CategorySelectCtrl',
    controllerAs: 'categories',
    scope: {
      taggable: '=taggable'
    }
  }
})
