angular.module('AppControllers').controller('CardSlotItemCtrl', ['$scope', 'Flash', function($scope, Flash) {
  this.initialize = function() {
    this.cardSlot = $scope.cardSlot;
    this.status = "pending"
  }
  this.hasCard = function() {
    return !!this.cardSlot.card.id
  }



  this.findCard = function() {
    if (!this.cardSlot.card.get('name')) {
      return
    }


    this.status = "searching"
    this.cardSlot.card.findByName({
      success:function(resp) {
        var text = this.cardSlot.card.get('name') + ' has been found';
        this.cardSlot.setCard(this.cardSlot.card);
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

  this.destroy = function() {
    this.cardSlot.removeFromCollections();
  }

  this.initialize();
}])
