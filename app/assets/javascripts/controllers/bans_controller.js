;angular.module('AppControllers').controller('BansCtrl', ['Ban', 'BaseCollection', 'CardCollection', function(Ban, BaseCollection, CardCollection) {

  this.initialize = function() {
    this.list = new BaseCollection({
      model: Ban,
      url: 'api/bans'
    })
    this.list.fetch();
    this.searchCollection = new CardCollection({
      url: 'api/cards/search'
    })
    this.newBan = new Ban({});
  };


  this.fetchNames = function() {
    this.searchCollection.fetch({
      clearModels: true,
      success: this.displayName.bind(this);
    })
  }


  this.initialize();
}]);
