class Printing < ActiveRecord::Base
  belongs_to :card
  belongs_to :card_set

  validates :card_id, :card_set_id, presence: true
  validates :multiverse_id, presence: true, uniqueness: true


  def self.create_from_json(data)
    card = Card.find_by(name: data["name"]) || Card.create_from_json(data)
    byebug if card.id.nil?
    raise StandardError if card.id.nil?
    printing = self.new({
      card_id: card.id,
      multiverse_id: data["multiverseid"],
      flavor_text: data["flavor_text"],
      rarity: data["rarity"]
    })
    printing.save
    return printing
  end





  def image_url
     "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=#{self.multiverse_id}&type=card"
  end

end
