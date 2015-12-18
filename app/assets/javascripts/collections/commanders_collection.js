angular.module('AppCollections').factory('Commanders', ['CardCollection', function(CardCollection) {
  var Commanders = new CardCollection({
    url:"api/cards/commanders"
  })

  Commanders.tinyLeaders = function() {
    return this.where(function(card) {
      return (card.get('cmc') <= 3);
    })
  }

  return Commanders
}])
