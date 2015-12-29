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
      "category_ids[]": [],
    }
    this.initialize(options);
    this.alreadySeenIds = [];
    this.on('fetch', this.updateSearchInfo.bind(this));
  }

  BaseCollection.parentOf(SuggestionsCollection);



  SuggestionsCollection.prototype.updateSearchInfo = function() {
    this.searchOptions["included_colors[]"] = this.deck.colorIdentity();
    this.searchOptions["category_ids[]"] = this.deck.get('category_ids');
    this.searchOptions["excluded_card_ids[]"] = this.deck.cardIds().concat(this.alreadySeenIds);
    debugger
    this.searchOptions["format"] = this.deck.get("format");
    this.searchOptions['limit'] = 25;
  }

  SuggestionsCollection.prototype.currentCardIds = function() {
    return this.map(function(card) { return card.id });
  }

  SuggestionsCollection.prototype.excludeAll = function() {
    this.alreadySeenIds = this.alreadySeenIds.concat(this.currentCardIds());
    this.models = [];
    this.modelsById = {};
    this.modelsByCID = {};
    this.trigger('remove');
  }



  SuggestionsCollection.prototype.exclude = function(cards) {
    for (var i = 0; i < cards.length; i++) {
      this.remove(cards[i])
      this.alreadySeenIds.push(cards[i].id);
    }
  }

 return SuggestionsCollection;
}])
