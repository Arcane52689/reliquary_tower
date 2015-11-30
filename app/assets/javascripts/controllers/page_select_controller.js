angular.module('AppControllers').controller('PageSelectCtrl', ['Selected', function() {
  this.initialize = function() {
    this.currentPage = Selected.pageInfo.currentPage;
  }
}])
