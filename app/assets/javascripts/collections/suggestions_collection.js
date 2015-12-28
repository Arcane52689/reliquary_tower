angular.module('AppCollections').factory('SuggestionsCollection', ['BaseCollection', 'Card', function(BaseCollection, Card) {
  var SuggestionsCollection = function(options) {
    options.model = Card;
    options.url = "api/cards/suggestions"
    this.deck = options.deck
    this._searchOptions = {
      commander: false,
      tiny_leader: false,
      limit: 25,
      "included_colors[]": [],
      "excluded_card_names[]": [],
      "category_ids[]": []
    }
    this.initialize(options)

    this.on('fetch', this.beforeFetch.bind(this));
  }

  BaseCollection.parentOf(SuggestionsCollection);

  SuggestionsCollection.prototype.beforeFetch = function() {
    this.updateSearchInfo();

  }

  SuggestionsCollection.prototype.updateSearchInfo = function() {
    debugger
    this.searchOptions["included_colors[]"] = this.deck.colorIdentity();
    this.searchOptions["category_ids[]"] = this.deck.get('category_ids');
    this.searchOptions["excluded_card_names[]"] = this.deck.cardNames();
    this.searchOptions["format"] = this.deck.get("format");
    this.searchOptions['limit'] = 25;
  }


 return SuggestionsCollection;
}])
