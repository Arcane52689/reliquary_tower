angular.module('AppCollections').factory('CardSets', ['BaseCollection', function() {
  var CardSets = new BaseCollection({
    url: "./api/card_sets/index"
  })
}])
