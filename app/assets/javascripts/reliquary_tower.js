angular.module('AppModels', ['AngularModelFactory'])
angular.module("AppDirectives", [])
angular.module('AppControllers', [])








var app = angular.module('ReliquaryTower', ['templates', 'AngularModelFactory', 'ngRoute', 'AppModels', 'AppControllers', 'AppDirectives'])


app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
  $routeProvider.when('/', {
    templateUrl: 'home.html'
  })

}])
