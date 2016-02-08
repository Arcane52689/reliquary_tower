class CardSerializer < ActiveModel::Serializer
  attributes :id, :type_string, :supertypes, :subtypes, :types, :card_text_with_name, :name, :colors, :color_identity, :cmc, :mana_cost, :can_be_commander, :produces_mana

  has_many :printings

end
