angular.module('AppControllers').controller('CardSearchBarController', ['CardCollection', 'Selected', function(CardCollection, Selected) {
  this.initialize = function() {
    this.results = new CardCollection({
      url: 'api/cards/search',
      searchOptions: {
        name: "",
        limit: 15,
        orderBy: 'name'
      }
    })

  }

  this.updateResults = function() {
    this.results.fetch({clearModels: true})
    this.displayResults = true;
  }

  this.selectCard = function(id) {
    this.selected = this.results.find(id);
    this.results.searchOptions.name = "";
    Selected.objects.card = this.selected;
    this.displayResults = false;
  }

  this.hideResults = function() {
    this.displayResults = false;
  }



  this.initialize();
}])
