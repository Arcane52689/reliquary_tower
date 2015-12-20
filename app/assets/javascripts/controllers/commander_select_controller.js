angular.module("AppControllers").controller("CommanderSelectCtrl", [ 'CardCollection', 'Selected', 'Commanders', function(CardCollection, Selected, Commanders) {
  this.initialize = function() {
    this.deck = Selected.objects.deck;
    this.commanders = Commanders;
    this.commanders.fetch();
    this.suggestions = new CardCollection({
      url: 'api/cards/suggestions',
      searchOptions: {
        "included_colors[]": this.deck.colorIdentity(),
        is_tiny_leader: (this.deck.get('format') === 'Tiny Leaders'),
        taggings: [],
        card_text: "",
        commander: true,
        limit: 10
      }
    });
    if (this.hasCommander()) {
      this.searching = false;
    } else {
      this.searching = true;
    }
  }

  this.hasCommander = function() {
    return !!this.deck.commander();
  }



  this.updateNames = function() {
    var lowerName = this.name.toLowerCase()
    this.possibleCards = this.commanders.where(function(card) {
      return (card.get('name').toLowerCase().indexOf(lowerName) > -1)
    });
    this.searchingNames = true;
  }

  this.selectCommander = function(card) {
    this.deck.setCommander(card);
    this.name = card.get('name');
    this.searchingNames = false;
  }

  this.updateSearchInfo = function() {
    this.suggestions.searchOptions["included_colors[]"] = this.deck.colorIdentity();
    this.suggestions.searchOptions.taggings = this.deck.get('category_ids');

  }


  this.suggestCommanders = function() {
    this.updateSearchInfo();
    debugger
    this.suggestions.fetch();
  }




  this.initialize();
}])
