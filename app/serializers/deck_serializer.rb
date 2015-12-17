class DeckSerializer < ActiveModel::Serializer
  attributes :id, :name, :format
  has_many :card_slots
  has_many :category_ids
end
