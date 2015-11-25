angular.module('AppControllers').controller('CommanderListCtrl', ['CardCollection', function(CardCollection) {
  this.initialize = function() {
    this.list = new CardCollection({
      url: "api/cards/commanders"
    })
    this.list.fetch()

  }

  this.check = function() {
    debugger
  }




  this.initialize()

}])
