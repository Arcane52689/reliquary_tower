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

  this.goToPage = function(page) {
    if ((page > 0) && (page <= this.pageInfo.pages)) {
      this.pageInfo.currentPage = page
    }
  }

  this.pageList = function() {
    var page
    var pages = [];
    for ( var i = -2; i <3; i++) {
      page = this.pageInfo.currentPage + i;
      if ((page > 1) && (page < this.pageInfo.pages)) {
        pages.push(page);
      }
    }
    return pages
  }

  this.isSelected = function(page) {
    if (page === this.pageInfo.currentPage) {
      return "selected";
    } else {
      return "";
    }
  }



  this.initialize();
}])
