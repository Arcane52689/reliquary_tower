angular.module('AppControllers').controller('HomeCtrl', ['CurrentUser', 'Flash', function(CurrentUser, Flash) {
  this.user = CurrentUser


  this.logout = function() {

    this.user.logout({success: function(resp) {
      Flash.success("So long and thanks for all the fish")
    },
    error: function() {
      Flash.error("Whoops! Something went wrong. Try refreshing the page and see if you're still logged in")
    }
  });
  }

}])
