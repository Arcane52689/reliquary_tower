;angular.module('AppModels').factory('Deck', ['BaseModel', 'BaseCollection', 'CardSlot', function(BaseModel, BaseCollection, CardSlot) {
  var Deck = function(data) {
    this.initialize(data);
    this.urlBase = "api/decks";
    this.card_slots = new BaseCollection({
      model: CardSlot,
      comparator: ''
    });
  };

  BaseModel.parentOf(Deck);

  Deck.prototype.updateAttributes = function(data) {
    data = data || { category_ids: []};

    if (data.card_slots) {
      if (this.card_slots.any()) {
        this.card_slots.clearModels();
      }
      this.card_slots.addModels(data.card_slots);
      delete data.card_slots;
    }
    if (!data.category_ids) {
    }

    BaseModel.prototype.updateAttributes.call(this, data);
  };

  Deck.prototype.toJSON = function() {
    var data = {};
    data.deck = {};
    data.nameSpace = 'deck';
    data.deck.card_slots = this.card_slots.where(function(card_slot) {
      return card_slot.card.id
    }).map(function(card_slot) {
      return card_slot._toJSON();
    });
    return data;
  };

  Deck.prototype.addBlankSlot = function(options) {
    return this.card_slots.addModel({
      quantity: 1,
      location: options.location || 'main deck'
    });
  };

  Deck.prototype.mainDeck = function() {
    return this.card_slots.where(function(card_slot) {
      return card_slot.attributes.location === 'main deck'
    });
  };

  Deck.prototype.sideboard = function() {
    return this.card_slots.where(function(card_slot) {
      return card_slot.attributes.location === 'sideboard'
    });
  };

  Deck.prototype.commander = function() {
    var models = this.card_slots.all()
    for( var i = 0; i < models.length; i++ ) {
      if (models[i].get('location') === 'commander') {
        return models[i];
      }
    }
    return undefined;
  };

  Deck.prototype.setCommander = function(card) {
    if (this.commander()) {
      this.commander().setCard(card);
    } else {
      this.addBlankSlot({location: 'commander'}).setCard(card)
    }
  }




  Deck.prototype.colorIdentity = function() {


    var colors = {}, result = [];

    this.card_slots.each(function(slot) {
      if (slot.card.id) {
        slot.card.attributes.color_identity.forEach(function(color){
          colors[color] = true;
        })
      }
    })
    for (color in colors) {
      if (colors[color]) {
        result.push(color);
      }
    }
    return result;
  }



  return Deck;
}]);
