angular.module('AppDirectives').directive('cardSuggestions', function() {
  return {
    restrict: 'E',
    replace: true,
    templateUrl: 'cards/card_suggestions.html',
    controller: 'CardSuggestionsCtrl',
    controllerAs: 'suggestions'
  }
})
