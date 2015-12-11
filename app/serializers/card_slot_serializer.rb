class CardSlotSerializer < ActiveModel::Serializer
  attributes :id, :location, :card_id, :quantity

  has_one :card

end
