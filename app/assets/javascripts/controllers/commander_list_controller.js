angular.module('AppControllers').controller('CommanderListCtrl', ['CardCollection', 'Selected', '$scope', function(CardCollection, Selected, $scope) {
  this.initialize = function() {
    this.isCommanderList = true;
    this.lists = {
      all_commanders: new CardCollection({
        url: "api/cards/commanders"
      })
    }
    this.lists.all_commanders.fetch({
      success: function() {
        this.list = this.lists.all_commanders;
        this.lists.tiny_leaders = this.list.where(function(card) {
          return (card.get('cmc') <= 3);
        })
        this.updateDisplayed();
      }.bind(this)
    })
    $scope.$on('ColorSelect', this.updateDisplayed.bind(this))
    this.currentPage = Selected.currentPage();
  }


  this.toggleTinyLeaders = function() {
    if (this.list === this.lists.all_commanders) {
      this.list = this.lists.tiny_leaders
    } else {
      this.list = this.lists.all_commanders
    }
    this.updateDisplayed();

  }



  this.updateDisplayed = function() {
    var display

    var excluded = Selected.excludedColors();
    var included = Selected.selectedColors();

    var excludeCallback = function(card) {
      display = true;
      card.get('color_identity').forEach(function(color) {
        if (excluded.indexOf(color) > -1) {
          display = false
        }
      })
      return display;
    }

    var strictCallback = function(card) {
      display  = true;
      included.forEach(function(color){
        if (card.get('color_identity').indexOf(color) === -1 ) {
          display = false;
        }
      })
      if (!display) {
        return false;
      }
      excluded.forEach(function(color) {
        if (card.get('color_identity').indexOf(color) > -1) {
          display = false
        }
      })
      return display;
    }

    if (Selected.strict) {
      this.displayed = this.list.where(strictCallback)
    } else {
      this.displayed = this.list.where(excludeCallback)
    }

  }




  this.initialize()

}])
