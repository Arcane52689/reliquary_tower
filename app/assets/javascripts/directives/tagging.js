angular.module('AppDirectives').directive('tagging', function() {
  return {
    restrict: 'E',
    replace: true,
    templateUrl: 'categories/tagging.html',
    controller: 'TaggingCtrl',
    controllerAs: 'tagging',
    scope: {
      categoryId: '=categoryId',
      taggable: '=taggable'
    }
  }
})
