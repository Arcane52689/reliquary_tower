angular.module('AppModels', ['AngularModelFactory'])
angular.module('AppCollections', ['AppModels'])
angular.module("AppDirectives", [])
angular.module('AppControllers', [])








var app = angular.module('ReliquaryTower', ['templates', 'AngularModelFactory', 'ngRoute', 'AppModels', 'AppCollections', 'AppControllers', 'AppDirectives'])


app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
  $routeProvider.when('/', {
    templateUrl: 'home.html'
  })
  .when('/commanders', {
    templateUrl: 'cards/card_list.html',
    controller: 'CommanderListCtrl',
    contorllerAs: 'cards'
  })

}])
