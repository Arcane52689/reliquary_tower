class CardSet < ActiveRecord::Base

  validates :name, presence: true


  has_many :cards, dependent: :destroy

  def self.create_from_json(set_json)
    byebug
    self.create({

    })

  end

end
