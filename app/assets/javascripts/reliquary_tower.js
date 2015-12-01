angular.module('AppUtilities', [])
angular.module('AppModels', ['AngularModelFactory'])
angular.module('AppCollections', ['AppModels'])
angular.module("AppDirectives", [])
angular.module('AppControllers', [])








var app = angular.module('ReliquaryTower', ['templates', 'AngularModelFactory', 'ngRoute', 'AppModels', 'AppCollections', 'AppControllers', 'AppDirectives', 'AppUtilities', 'AngularFlash'])


app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
  $routeProvider.when('/', {
    templateUrl: 'home.html',
    controller: 'HomeCtrl',
    controllerAs: 'home'
  })
  .when('/commanders', {
    templateUrl: 'cards/card_list.html',
    controller: 'CommanderListCtrl',
    controllerAs: 'cards'
  })
  .when('/login', {
    templateUrl: 'login.html',
    controller: 'LoginCtrl',
    controllerAs: 'login'
  })

}])
