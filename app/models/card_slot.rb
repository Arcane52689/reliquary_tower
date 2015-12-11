class CardSlot < ActiveRecord::Base
  belongs_to :deck, inverse_of: :card_slots
  belongs_to :card

  validates :card_id, :quantity, presence: true


  def self.create_or_update(hash)
    if hash[:id]
      self.find(hash[:id]).update(hash)
    else
      self.new(hash)
    end
  end

end
