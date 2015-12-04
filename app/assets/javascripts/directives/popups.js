angular.module('AppDirectives').directive('popupContainer', function() {
  return {
    restrict: 'E',
    replace: true,
    templateUrl: 'popups/popup_container.html',
    controller: 'PopupCtrl',
    controllerAs: 'popups'
  }
})
