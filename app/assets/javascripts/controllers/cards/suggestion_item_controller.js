angular.module("AppControllers").controller("SuggestionItemCtrl", [ '$scope', function($scope) {
  this.initialize = function() {
    this.card = $scope.card;
  }

  this.altText = function() {
    var text = 'Name: ' + this.card.get("name") + "\n Card text: " + this.card.get('card_text');
    return text;
  }

  this.initialize();
}])
