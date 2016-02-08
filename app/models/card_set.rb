class CardSet < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true


  has_many :printings, dependent: :destroy



end
