angular.module("AppControllers").controller("CardModalCtrl", ['Selected', 'Displayed', function(Selected, Displayed) {
  this.initialize = function() {

    this.card = Selected.objects.card;
    debugger
    this.card.convertManaCost();
    this.card.convertCardText();
  }

  this.close = function() {
    Displayed.popups.cardView = false
  }

  this.initialize();
}])
