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
  }

  BaseCollection.parentOf(SuggestionsCollection);

  SuggestionsCollection.prototype.beforeFetch = function() {
    var silent_merge = function(obj1, obj2) {
      // keys in obj2 won't overwrite obj 1
      for (key in obj2) {
        if (!obj1.hasOwnProperty(key)) {
          obj1[key] = obj2[key];
        }
      }
    }

    this.updateSearchInfo();
    silent_merge(this.searchInfo, this._searchInfo)
  }

  SuggestionsCollection.prototype.updateSearchInfo = function() {
    this._searchInfo["included_colors[]"]= this.deck.colorIdentity();
    this._searchInfo["category_ids[]"] = this.deck.get('category_ids');
    this._searchInfo["excluded_card_names[]"] = this.deck.cardNames();
    this._searchInfo["format"] = this.deck.get("format");
  }




}])
