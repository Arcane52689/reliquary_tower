class Deck < ActiveRecord::Base
  attr_accessor :card_limit, :card_minimum
  @format = "Deck"
  @card_minimum = 0
  @card_limit = Float::INFINITY
  validates :name, presence: true

  belongs_to :user
  # validate :not_too_many_cards, :not_too_few_cards
  after_initialize :set_variables

  def self.all_in_format
    self.all.where(format: @format)
  end

  def self.format
    @format
  end

  def self.card_limit
    @card_limit
  end

  def self.card_minimum
    @card_minimum
  end


  def set_variables
    self.card_limit = self.class.card_limit
    self.card_minimum = self.class.card_minimum
    self.format ||= self.class.format
  end

end


class Commander < Deck
  @format = "Commander"
  @card_limit = 100
  @card_maximum = 100






end

class TinyLeaders < Deck
  @format = "Tiny Leaders"
  @card_limit = 50
  @card_maximum = 50


end

class Standard < Deck
  @format = "Standard"
  @card_limit = 60


end

class Modern < Deck
  @format = "Modern"
  @card_limit = 60
end
