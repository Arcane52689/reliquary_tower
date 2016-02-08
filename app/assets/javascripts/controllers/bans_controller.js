;angular.module('AppControllers').controller('BansCtrl', ['Ban', 'BaseCollection', 'CardCollection', 'Flash', function(Ban, BaseCollection, CardCollection, Flash) {
  this.initialize = function() {
    this.formats = ['Modern', 'Standard', 'Commander', 'Tiny Leaders']
    this.list = new BaseCollection({
      model: Ban,
      url: 'api/bans'
    })
    this.bannedIn = {};
    this.list.fetch({
      success: this.updateDisplay.bind(this)
    });
    this.searchCollection = new CardCollection({
      url: 'api/cards/search',
      searchOptions: {
        name: "",
        limit: 10
      }
    })
    this.newBan = new Ban({format: 'Commander'});
  };


  this.fetchNames = function() {
    this.searchCollection.fetch({
      clearModels: true,
      success: this.displayNames.bind(this)
    })
  }

  this.displayNames = function(resp) {
    this.displayingNames = true;
    console.log(resp.length)
  }

  this.select = function(card) {
    this.selectedCard = card;
    this.searchCollection.searchOptions.name = "";
    this.displayingNames = false;
  }

  this.updateDisplay = function() {

    var format, i
    for (i = 0; i < this.formats.length; i++) {
      format = this.formats[i]
      this.bannedIn[format] = this.list.where(function(ban) {
        return ban.get('format') === format;
      }).all();
    }
  }


  this.addBan = function() {
    this.newBan.attributes.card_name = this.selectedCard.get('name');
    this.newBan.save({
      success: function() {
        Flash.success(this.newBan.attributes.card_name + " was successfully banned");
        this.list.add(this.newBan);
        this.newBan = new Ban({});
        this.selectedCard = undefined;
        this.updateDisplay();
      }.bind(this),
      error: function(resp) {
        Flash.error(resp.error)
      }
    })
  }

  this.initialize();
}]);
