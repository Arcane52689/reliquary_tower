angular.module('AppCollections').factory('CardSets', ['BaseCollection', function(BaseCollection) {
  var CardSets = new BaseCollection({
    url: "./api/card_sets"
  })


  return CardSets
}])
