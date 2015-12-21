class CardSerializer < ActiveModel::Serializer
  attributes :id, :image_url, :type_string, :supertypes, :subtypes, :types, :card_text, :name, :colors, :color_identity, :cmc, :mana_cost, :can_be_commander, :produces_mana


end
