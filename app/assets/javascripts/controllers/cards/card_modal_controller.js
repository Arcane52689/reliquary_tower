angular.module("AppControllers").controller("CardModalCtrl", ['Selected', 'Displayed', function(Selected, Displayed) {
  this.initialize = function() {

    this.card = Selected.objects.card;
    this.card.convertManaCost();
  }

  this.close = function() {
    Displayed.popups.cardView = false
  }

  this.initialize();
}])