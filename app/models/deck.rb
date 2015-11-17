class Deck < ActiveRecord::Base
  attr_accessor :card_limit, :card_minimum
  belongs_to :user
  # validate :not_too_many_cards, :not_too_few_cards

end


class Commander < Deck
  self.card_limit = 100
  self.card_minimum = 100
  self.format = 'Commander'

end

class TinyLeaders < Deck
  self.card_limit = 50
  self.card_minimum = 50
  self.format = 'Tiny Leaders'
end

class Standard < Deck
  self.card_limit = Float::INFINITY
  self.card_minimum = 60
  self.format = 'Standard'

end

class Modern < Deck
  self.card_limit = Float::INFINITY
  self.card_minimum = 60
  self.format = 'Standard'

end
