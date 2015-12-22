angular.module('AppDirectives').directive('cardSuggestions', function() {
  return {
    restrict: 'E',
    replace: true,
    templateUrl: 'cards/suggestion_list.html',
    controller: 'CardSuggestionsCtrl',
    controllerAs: 'suggestions',
    scope: {
      deck: "=deck"
    }
  }
})
