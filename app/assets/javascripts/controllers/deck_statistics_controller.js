angular.module("AppControllers").controller("DeckStatisticsCtrl", ['$scope', function($scope) {
  this.initialize = function() {
    this.deck = $scope.deck
    this.countCards();
    $scope.$watch(function() {
      return this.deck.card_slots.models.length
    }.bind(this), this.updateDisplay.bind(this));
  }

  this.countCards = function() {
    this.mainDeckTotal = 0;
    this.typeCounts =  {};
    this.deck.mainDeck().each(function(slot) {
      if (slot.card.id) {
        this.mainDeckTotal += slot.get('quantity')
        slot.card.get('types').forEach(function(type) {
          if (!this.typeCounts[type]) {
            this.typeCounts[type] = {count: slot.get("quantity"), type: type}
          } else {
            this.typeCounts[type].count += slot.get("quantity")
          }
        }.bind(this))
      }
    }.bind(this))
  }

  this.updateDisplay = function() {
    this.countCards();
    this.manaProducers = this.deck.manaProducers();
  }



  this.initialize();
}])
