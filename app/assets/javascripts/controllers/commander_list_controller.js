angular.module('AppControllers').controller('CommanderListCtrl', ['Commanders', 'Selected', '$scope', function(Commanders, Selected, $scope) {
  this.initialize = function() {
    this.isCommanderList = true;
    this.lists = {
      all_commanders: Commanders
    }
    this.lists.all_commanders.fetch({
      success: function() {
        this.list = this.lists.all_commanders;
        this.lists.tiny_leaders = this.list.tinyLeaders();
        this.updateDisplayed();
      }.bind(this)
    })
    $scope.$on('ColorSelect', this.updateDisplayed.bind(this))
    this.pageInfo = Selected.pageInfo
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

    var displayCallback = function(card) {
      display = true;
      card.get('color_identity').forEach(function(color) {
        if (excluded.indexOf(color) > -1) {
          display = false
        }
      })
      if (!display) {
        return display
      }
      included.forEach(function(color) {
        if (card.get('color_identity').indexOf(color) === -1) {
          display = false;
        }
      })
      return display;

    }

    this.displayed = this.list.where(displayCallback)

    this.pageInfo.pages = this.displayed.pages()
    this.pageInfo.currentPage = 1;

  }


  this.showPage = function() {
    if (this.displayed) {
      return this.displayed.getPage(this.pageInfo.currentPage);
    }
    return []
  }

  this.initialize()

}])
