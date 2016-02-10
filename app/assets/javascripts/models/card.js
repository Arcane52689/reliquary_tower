angular.module('AppModels').factory('Card', ['BaseModel', '$http', '$sce', function(BaseModel, $http, $sce) {
  var Card = function(data) {
    data = data || {};
    this.initialize(data)
    this.urlBase = "api/cards"
  }



  BaseModel.parentOf(Card)

  Card.findByName = function(name, options)  {
    var card = new Card({
      name: name
    });
    card.findByName(options);
    return card;
  }

  Card.prototype.updateAttributes = function(data) {
    data
    if (data["card_text_with_name"]) {
      data["card_text"] = data["card_text_with_name"];

      delete data.card_text_with_name
    }
    BaseModel.prototype.updateAttributes.call(this, data);
    if (this.attributes.printings && this.attributes.printings.length > 0) {
      this.selectedPrinting = this.attributes.printings[0];
    }
  }

  Card.prototype.imageUrl = function() {
    if (this.selectedPrinting) {

      return this.selectedPrinting.image_url
    }
    else {
      return ""
    }
  }

  Card.prototype.hasAlternateFace = function() {
    return !! this.attributes.alternate_card_name
  }

  Card.prototype.findByName = function(options) {

    options = options || {};
    $http.get("api/cards/find_by", {params: {name: this.get('name')}}).success(function(resp) {
      this.updateAttributes(resp)
      options.success && options.success(resp);
    }.bind(this)).error(function(resp) {
      options.error && options.error(resp)
    })
  }

  Card.prototype.selectPrinting = function(id) {

    for (var i = 0; i < this.attributes.printings.length; i++) {
      if (this.attributes.printings[i].id == id) {
        this.selectedPrinting = this.attributes.printings[i];
      }
    }
  }

  Card.prototype.isFlipped = function() {
    return this.attributes.is_flip_card;
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
