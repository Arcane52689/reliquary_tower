angular.module('AppCollections').factory('DeckCollection', ['BaseCollection', 'Deck', 'CurrentUser', function(BaseCollection, Deck, CurrentUser) {
  var DeckCollection = new BaseCollection({
    model: Deck,
    url: 'api/decks/'
  })




  return DeckCollection;
}])
