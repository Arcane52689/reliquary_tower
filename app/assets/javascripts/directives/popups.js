angular.module('AppDirectives').directive('popupContainter', function() {
  return {
    restrict: 'E',
    replace: true,
    templateUrl: 'popups/popup_container.html',
    controller: 'PopupCtrl',
    controlleras: 'popups'
  }
})
