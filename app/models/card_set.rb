class CardSet < ActiveRecord::Base

  validates :name, presence: true




  def add_card_ids(arr)
    self.card_ids = self.card_ids.concat(arr).uniq
    self.save
  end

end
