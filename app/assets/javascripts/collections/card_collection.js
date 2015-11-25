;angular.module("AppCollections").factory('CardCollection', ['BaseCollection', 'Card', function(BaseCollection, Card) {
    var CardCollection = function(options) {
      options.model = Card
      this.initialize(options)
    }

    BaseCollection.parentOf(CardCollection)

}]);
