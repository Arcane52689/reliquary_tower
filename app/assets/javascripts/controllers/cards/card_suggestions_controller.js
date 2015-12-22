angular.module("AppControllers").controller("CardSuggestionsCtrl", [ '$scope', 'SuggestionsCollection' function($scope, SuggestionsCollection) {

  this.initialize = function() {
    this.deck = $scope.deck
    this.collection = new SuggestionsCollection({
      searchOptions: {
        is_tiny_leader: (this.deck.get('format') === 'Tiny Leaders'),
        card_text: ""
      }
    });
  }

  this.fetch = function() {
    this.collection.fetch();
  }



  this.initialize();
}])
