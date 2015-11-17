class Deck < ActiveRecord::Base
  attr_accessor :card_limit, :card_minimum
  belongs_to :user
  # validate :not_too_many_cards, :not_too_few_cards
  after_initialize :set_variables



  def set_variables
    self.card_limit = Float::infinity
    self.card_minimum = 0
    self.format = 'Deck'
  end

end


class Commander < Deck
  def set_variables
    self.card_limit = 100
    self.card_minimum = 100
    self.format = 'Commander'
  end

end

class TinyLeaders < Deck
  def set_variables
    self.card_limit = 50
    self.card_minimum = 50
    self.format = 'Tiny Leaders'
  end
end

class Standard < Deck
  def set_variables
    self.card_limit = Float::INFINITY
    self.card_minimum = 60
    self.format = 'Standard'
  end
end

class Modern < Deck
  def set_variables
    self.card_limit = Float::INFINITY
    self.card_minimum = 60
    self.format = 'Standard'
  end
end
