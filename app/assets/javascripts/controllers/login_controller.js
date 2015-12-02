angular.module('AppControllers').controller('LoginCtrl', ['Flash', 'CurrentUser', '$location',function(Flash, CurrentUser, $location) {
  this.initialize = function() {
    this.user = CurrentUser;
    this.signingUp = false;

  }

  this.login = function() {
    this.user.login({
      success:function(resp) {
        $location.path('/');
        Flash.success("Welcome " + CurrentUser.get('username') )
    }});
  }

  this.signUp = function() {
    this.user.save({
      success: function() {
        this.user.attributes.password = undefined;
        Flash.success("Welcome " + this.user.get('username') + ", Thanks for signing up")
      }.bind(this),
      error: function(resp) {
        Flash.error(resp)
      }
    })
  }

  this.showLogin = function() {
    this.signingUp = false;
  }

  this.showSignUp = function() {
    this.signingUp = true;
  }




  this.initialize();
}])
