angular.module('AppControllers').controller('LoginCtrl', ['Flash', 'CurrentUser', '$location',function(Flash, CurrentUser, $location) {
  this.initialize = function() {
    this.user = CurrentUser
  }

  this.login = function() {
    this.user.login({
      success:function(resp) {
        debugger;
        $location.path('/');
        Flash.success("Welcome " + CurrentUser.get('username') )
    }});
  }




  this.initialize();
}])
