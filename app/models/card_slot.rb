class CardSlot < ActiveRecord::Base
  belongs_to :deck
  belongs_to :card

  validates :card_id, :deck_id, :quantity, :status, presence: true

  

end
