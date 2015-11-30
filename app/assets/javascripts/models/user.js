angular.module('AppModels').factory('CurrentUser', ['BaseModel', '$http', function(BaseModel, $http) {
  var User = function(data){
    this.initialize(data);
    this.urlBase = "./api/users"
    this.idIsOptional = true
  }

  User.prototype.url = function() {
    return "./api/users/"
  }

  User.prototype.login = function() {
    $http.post('./api/session/', {user:{
      email_or_username: this.get('email_or_username'),
      password: this.get('password')
    }.success(function() {
      this.set('password', "");
    })
    })
  }



  BaseModel.parentOf(User);

  var CurrentUser = new User({});
  CurrentUser.fetch();



  return CurrentUser;

}])
