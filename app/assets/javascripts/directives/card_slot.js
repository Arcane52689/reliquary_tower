angular.module('AppDirectives').directive('cardSlot', function() {
  return {
    replace: true,
    restrict: 'E',
    templateUrl: 'card_slots/card_slot_item.html',
    controller: 'CardSlotItemCtrl',
    controllerAs: 'slot',
    scope: {
      loading: '=loading',
      cardSlot: '=cardSlot'
    },
    link: function(scope, element) {
      if (!scope.loading) {
        element.children()[0].children[0].children[1].focus()
      }
    }
  }
})
