class CardSerializer < ActiveModel::Serializer





  attributes :id, :type_string, :supertypes, :subtypes, :types, :card_text_with_name, :name, :colors, :color_identity, :cmc, :mana_cost, :can_be_commander, :produces_mana, :alternate_card_name, :is_flip_card



  has_many :printings

end
