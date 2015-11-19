class Deck < ActiveRecord::Base
  attr_accessor :card_limit, :card_minimum
  @format = "Deck"
  @card_minimum = 0
  @card_limit = Float::INFINITY

  has_many :card_slots
  has_many :cards, through: :card_slots, as: :card

  belongs_to :user
  # validate :not_too_many_cards, :not_too_few_cards
  after_initialize :set_variables

  validates :name, presence: true
  validate :ensure_right_number_of_cards

  def self.all_in_format(format=@format)
    self.all.where(format: format)
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

  def total_cards
    self.card_slots.where(status: "main deck").inject(0) { |acc, obj| acc + obj.quantity}
  end

  def ensure_right_number_of_cards
    return nil if self.is_prototype
    total = self.total_cards
    if total < self.card_minimum
      self.errors[:cards] << "Not enough cards"
    elsif total > self.card_limit
      self.errors[:cards] << "Too many cards"
    else
    end
  end





end


class Commander < Deck
  @format = "Commander"
  @card_limit = 99
  @card_minimum = 99


  validate :ensure_one_commander


  def ensure_one_commander
    if self.card_slots.where(status: 'Commander').count > 1
      self.errors[:card_limit] << "There can only be one Commander"
    end
  end




end

class TinyLeaders < Deck
  @format = "Tiny Leaders"
  @card_limit = 49
  @card_minimum = 49

  validate :ensure_one_commander


  def ensure_one_commander
    if self.card_slots.where(status: 'Commander').count > 1
      self.errors[:card_limit] << "There can only be one Commander"
    end
  end

end

class Standard < Deck
  @format = "Standard"
  @card_minimum = 60
  @card_limit = Float::INFINITY



end

class Modern < Deck
  @format = "Modern"
  @card_minimum = 60
  @card_limit = Float::INFINITY

end
