angular.module("AppControllers").controller("DeckStatisticsCtrl", ['$scope' function($scope) {
  this.initialize = function() {
    this.deck = $scope.deck
  }

  this.totalInMainDeck = function() {
    var count = 0
    this.deck.mainDeck().each(function(slot) {
      count+= slot.get('quantity')
    })
  }



  this.initialize();
}])
