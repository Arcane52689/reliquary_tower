angular.module('AppControllers').controller('PageSelectCtrl', ['Selected', function(Selected) {
  this.initialize = function() {
    this.pageInfo = Selected.pageInfo
  }


  this.next = function() {
    if (this.pageInfo.currentPage < this.pageInfo.pages) {
      this.pageInfo.currentPage += 1;
    }
  }

  this.prev = function() {
    if (this.pageInfo.currentPage > 1) {
      this.pageInfo.currentPage -= 1
    }
  }



  this.initialize();
}])
