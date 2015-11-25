angular.module('AppControllers').controller('CommanderListCtrl', ['CardCollection', 'Selected', '$scope', function(CardCollection, Selected, $scope) {
  this.initialize = function() {
    this.list = new CardCollection({
      url: "api/cards/commanders"
    })
    this.list.fetch({
      success: function() {
        this.updateDisplayed();
      }.bind(this)
    })
    $scope.$on('ColorSelect', this.updateDisplayed.bind(this))

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
