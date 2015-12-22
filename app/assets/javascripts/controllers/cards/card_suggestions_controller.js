angular.module("AppControllers").controller("CardSuggestionsCtrl", [ '$scope', 'SuggestionsCollection', function($scope, SuggestionsCollection) {

  this.initialize = function() {
    this.deck = $scope.deck
    this.page = 1 ;
    this.collection = new SuggestionsCollection({
      deck: this.deck,
      searchOptions: {
        is_tiny_leader: (this.deck.get('format') === 'Tiny Leaders'),
        card_text: ""
      },
      perPage: 5
    });
  }

  this.fetch = function() {
    this.collection.fetch({
      success: function(resp) {
        debugger
      }.bind(this)
    });
  }

  this.nextPage = function() {
    this.page = this.page + 1
    if (this.page > this.collection.pages()) {
      this.page = 1;
    }
  }

  this.prevPage = function() {
    this.page = this.page - 1
    if (this.page <= 0) {
      this.page = this.collection.pages();
    }
  }


  this.initialize();
}])