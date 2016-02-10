angular.module("AppControllers").controller("CardModalCtrl", ['Selected', 'Displayed', "Card", "CardSets", function(Selected, Displayed, Card, CardSets) {
  this.initialize = function() {

    this.card = Selected.objects.card;
    this.card.convertManaCost();
    this.card.convertCardText();
    if (this.card.get("alternate_card_name")) {
      this.alternateCard = Card.findByName(this.card.get("alternate_card_name"))
    }
    if (CardSets.none()) {
      CardSets.fetch({
        success: function() {
          this.addVersions();
        }.bind(this)
      });
    } else {
      this.addVersions();
    }
  }

  this.addVersions = function() {
    this.card.attributes.printings.forEach(function(printing) {
      printing.set_name = CardSets.find(printing.card_set_id).get('name');
    })
  }

  this.close = function() {
    Displayed.popups.cardView = false
  }



  this.initialize();
}])
