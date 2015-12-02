;angular.module("AppCollections").factory('CardCollection', ['BaseCollection', 'Card', function(BaseCollection, Card) {
    var CardCollection = function(options) {
      options.model = Card
      options.searchOptions = options.searchOptions || {
        name: "",
        card_text: "",
      };
      this.initialize(options)
    }

    BaseCollection.parentOf(CardCollection)

    return CardCollection
}]);
