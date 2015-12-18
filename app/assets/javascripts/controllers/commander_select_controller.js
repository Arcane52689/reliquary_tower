angular.module("AppControllers").controller("CommanderSelectCtrl", [ 'CardCollection', 'Selected', 'Commanders', function(CardCollection, Selected, Commanders) {
  this.initialize = function() {
    this.deck = Selected.objects.deck;
    this.commanders = Commanders;
    Commanders.fetch();
    this.suggestions = new CardCollection({
      url: 'api/cards/suggestions',
      searchOptions: {
        included_colors: this.deck.colorIdentity(),
        exculded_colors: [],
        is_tiny_leader: (this.deck.get('format') === 'Tiny Leaders'),
        taggings: [],
        name: "",
        card_text: "",
        commander: true
      }
    });
    this.cardSlot = this.deck.commander();

    if (this.hasCommander()) {
      this.searching = false;
    } else {
      this.searching = true;
    }
  }

  this.hasCommander = function() {
    return !!this.cardSlot.card.id
  }

  this.suggestCommander = function() {
    this.searching = true;
    this.collection.fetch()
  }

  this.updateNames = function() {
    var lowerName = this.name.toLowerCase()
    this.possibleCards = this.commanders.where(function(card) {
      return (card.get('name').toLowerCase().indexOf(lowerName) > -1)
    });
    this.searchingNames = true;
  }

  this.selectCommander = function(card) {

  }





  this.initialize();
}])
