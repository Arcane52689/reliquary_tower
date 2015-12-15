angular.module('AppDirectives').directive('commanderSelect', function() {
  return {
    restrict: "E",
    replace: true,
    templateUrl: 'cards/commander_select.html',
    controller: 'CommanderSelectCtrl',
    controllerAs: 'commander'
  };
})
