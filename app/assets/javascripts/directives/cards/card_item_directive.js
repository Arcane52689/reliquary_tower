angular.module('AppDirectives').directive('cardItem', function() {
  return {
    restrict: 'E',
    replace: true,
    templateUrl: 'cards/card_item.html',
    controller: 'CardItemCtrl',
    controllerAs: 'item',
    scope: {
      card: '=card'
    }
  }
})
