angular.module('AppModels').factory('CurrentUser', ['BaseModel', '$http', function(BaseModel, $http) {
  var User = function(data){
    this.initialize(data);
    this.urlBase = "./api/users"
    this.idIsOptional = true
  }

  BaseModel.parentOf(User);


  User.prototype.url = function() {
    return "./api/users/"
  }



  User.prototype.login = function(options) {
    $http.post('./api/session/', {user:{
      email_or_username: this.get('email_or_username'),
      password: this.get('password')
    }}).success(function(resp) {
      options.success && options.success()
    }).error(function(resp) {
      options.error && options.error()
    })
  }

  User.prototype.logout = function(options) {
    $http.delete('/api/session/').success(function(resp){
      this.attributes = {};
      options.success && options.success()
    }).error(function(resp) {
    })
  }




  var CurrentUser = new User({});
  CurrentUser.fetch();



  return CurrentUser;

}])
