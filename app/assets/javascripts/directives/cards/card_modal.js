angular.module('AppDirectives').directive('cardModal', function() {
  return {
    restrict: 'E',
    replace: true,
    templateUrl: 'cards/card_modal.html',
    controller: 'CardModalCtrl',
    controllerAs: 'modal'
  }
})
