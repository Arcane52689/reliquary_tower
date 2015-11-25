angular.module('AppControllers').controller('CommanderListCtrl', ['CardCollection', function() {
  this.initialize = function() {
    this.cards = new CardCollection({
      url: "api/suggestions/commander"
    })
    this.cards.fetch()
  }





  this.initialize()

}])
