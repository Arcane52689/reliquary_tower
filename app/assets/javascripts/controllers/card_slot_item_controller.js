angular.module('AppControllers').controller('CardSlotItemCtrl', ['$scope', 'Flash', function($scope, Flash) {
  this.initialize = function() {
    this.cardSlot = $scope.cardSlot;
    this.status = "pending"
    this.numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100]

  }

  this.hasCard = function() {
    return !!this.cardSlot.card.id
  }

  this.numbers = function() {

  }

  this.findCard = function() {
    if (!this.cardSlot.card.get('name')) {
      return
    }


    this.status = "searching"
    this.cardSlot.card.findByName({
      success:function(resp) {
        var text = this.cardSlot.card.get('name') + ' has been found';
        this.status = "found";
        Flash.success(text);
      }.bind(this),
      error: function(resp) {
        Flash.error(resp.error);
        this.status = "not-found";
      }.bind(this)
    })
  }

  this.checkStatus= function() {
    return this.status
  }

  this.initialize();
}])
