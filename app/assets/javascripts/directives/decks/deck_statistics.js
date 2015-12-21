angular.module('AppDirectives').directive('deckStatistics', function() {
  return {
    restrict: 'E',
    replace: true,
    templateUrl: 'decks/deck_statistics.html',
    controller: 'DeckStatisticsCtrl',
    controllerAs: 'stats',
    scope: {
      deck: "=deck'"
    }
  }
})
