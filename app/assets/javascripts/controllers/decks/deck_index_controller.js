angular.module("AppControllers").controller("DeckIndexCtrl", [ 'DeckCollection', '$location', function(DeckCollection, $location) {
  this.initialize = function() {
    this.decks = DeckCollection
    this.decks.fetch()
  }


  this.goToDeck = function(id) {
    $location.path('/decks/' + id);
  }

  this.initialize();
}])
