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

  Deck.prototype.manaProducers = function() {
    var result = {};
    this.mainDeck().each(function(slot) {
      if (slot.card.id) {

        slot.card.attributes.produces_mana.forEach(function(mana) {
          if (result[mana]) {
            result[mana].count += slot.get('quantity');
          } else {
            result[mana] = {
              type: mana,
              count: slot.get('quantity')
            }
          }
        })
      }
    })
    return result
  }

  Deck.prototype.totalInLocation = function(location) {
    var count = 0;
    this.card_slots.each(function(slot) {
      if ((slot.get('location') === location) && (slot.card.id)) {
        count += slot.get('quantity');
      }
    })
    return count;
  }


  Deck.prototype.cardNames = function() {
    return this.card_slots.map(function(slot) {
      return slot.card.attributes.name;
    })
  }

  Deck.prototype.cardIds = function() {
    var result = [];
    this.card_slots.each(function(slot) {
      if (slot.attributes.card_id) {
        result.push(slot.attributes.card_id);
      }
    })
    return result;
  }

  Deck.prototype.updateManaSymbols = function() {
    this.manaSymbols = {
      '1': 0
    };
    var symbols, i, symbol
    var re = /{\w}|{\w\/\w}/g
    this.card_slots.each(function(slot){
      if (slot.card.id) {
        symbols = slot.card.get('mana_cost').match(re);
        for (i = 0; i < symbols.length; i++ ) {
          symbol = symbols[i].slice(1,-1).toLowerCase();
          if (symbol.length > 1) {
            symbol = symbol.split("/").join("");
          }
          if (parseInt(symbol)) {
            this.manaSymbols['1'] += parseInt(symbol)
          } else {
            this.manaSymbols[symbol] = this.manSybmols[symbol] + 1 || 1
          }
        }
      }
    })
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
