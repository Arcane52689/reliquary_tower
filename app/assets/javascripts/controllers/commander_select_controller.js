angular.module("AppControllers").controller("CommanderSelectCtrl", [ 'CardCollection', 'Selected', function(CardCollection, Selected) {
  this.initialize = function() {
    this.deck = Selected.objects.deck;
    this.collection = new CardCollection({
      url: 'api/cards/commanders',
      searchOptions: {
        included_colors: this.deck.colorIdentity(),
        exculded_colors: [],
        is_tiny_leader: (this.deck.get('format') === 'Tiny Leaders'),
        taggings: [],
        name: "",
        card_text: ""
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




  this.initialize();
}])
