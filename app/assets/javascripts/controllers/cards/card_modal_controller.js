angular.module("AppControllers").controller("CardModalCtrl", ['Selected', 'Displayed', "Card", function(Selected, Displayed, Card) {
  this.initialize = function() {

    this.card = Selected.objects.card;
    this.card.convertManaCost();
    this.card.convertCardText();
    if (this.card.get("alternate_card_name")) {
      this.alternateCard = Card.findByName(this.card.get("alternate_card_name"))
    }
  }

  this.close = function() {
    Displayed.popups.cardView = false
  }

  this.initialize();
}])
