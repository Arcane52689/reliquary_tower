;
angular.module('AppControllers').controller('HeaderCtrl', ['CurrentUser', 'Displayed', '$rootScope', function (CurrentUser, Displayed, $rootScope) {
  this.initialize = function() {
    this.user = CurrentUser;

    this.formats = [
      {
        name: 'EDH'
      },
      {
        name: 'Tiny Leaders'
      },
      {
        name: 'Standard'
      },
      {
        name: 'Modern'
      }
    ]


  }


  this.showLoginView = function() {
    Displayed.popups.loginView = true;
  }

  this.loggedIn = function() {
    return CurrentUser.logged_in()
  }

  this.logout = function() {
    CurrentUser.logout();
  }




  this.initialize();
}]);
