angular.module("AppControllers").controller("CardItemCtrl", ['$scope', 'Selected', 'Displayed', function($scope, Selected, Displayed) {
  this.initialize = function()  {
    this.card = $scope.card
  }

  this.displayModal = function() {
    Selected.objects.card = this.card;
    Displayed.popups.cardView = true;
  }



  this.initialize();
}]);
