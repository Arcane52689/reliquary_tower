class DeckSerializer < ActiveModel::Serializer
  attributes :id, :name, :format
  has_many :card_slots
end
