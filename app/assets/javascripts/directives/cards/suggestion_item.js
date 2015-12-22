angular.module('AppDirectives').directive('suggestionItem', function() {
  return {
    restrict: 'E',
    replace: true,
    templateUrl: 'cards/suggestion_item.html',
    controller: 'SuggestionItemCtrl',
    controllerAs: 'suggestion',
    scope: {
      card: "=card",
      deck: "=deck"
    }
  }
})
