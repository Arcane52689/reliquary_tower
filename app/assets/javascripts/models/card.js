angular.module('AppModels').factory('Card', ['BaseModel', '$http', '$sce', function(BaseModel, $http, $sce) {
  var Card = function(data) {
    this.initialize(data)
    this.urlBase = "api/cards"
  }



  BaseModel.parentOf(Card)


  Card.prototype.findByName = function(options) {

    options = options || {};
    $http.get("api/cards/find_by", {params: {name: this.get('name')}}).success(function(resp) {
      this.updateAttributes(resp)
      options.success && options.success(resp);
    }.bind(this)).error(function(resp) {
      options.error && options.error(resp)
    })
  }


  Card.prototype.convertManaCost = function() {
    var swap = function(string) {
      string = string.toLowerCase();
      if (string.search(/\//) > -1) {
        string = string.split('/').join('');
      }
      return '<span class="mana mana-' + string.slice(1,-1) + '"></span>'
    }
    var re = /{\w}|{\w\/\w}/g
    var displayCost = "";
    var matches = this.attributes.mana_cost.match(re);
    for (var i = 0; i < matches.length; i++) {
      displayCost += swap(matches[i]);
    }
    this.displayCost = $sce.trustAsHtml(displayCost);
  }

  Card.prototype.convertCardText = function() {
    var displayText = this.attributes.card_text
    var re = /{\w}|{\w\/\w}/g
    var replacement = function(string) {
      string = string.toLowerCase();
      if (string.search(/\//) > -1) {
        string = string.split('/').join('');
      }
      return '<span class="mana mana-' + string.slice(1,-1) + '"></span>'
    }
    var matches = displayText.match(re);
    if (matches) {
      for (var i = 0; i < matches.length; i++) {
        var match = matches[i];
        displayText = displayText.replace(match, replacement(match));
      }
    }
    this.displayText = $sce.trustAsHtml(displayText);
  }


  return Card
}])
