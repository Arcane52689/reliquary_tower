class DeckSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :card_slots
end
