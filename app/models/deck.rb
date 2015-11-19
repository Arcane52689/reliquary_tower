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

  validates :name, :user_id, presence: true
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


  def add_cards(card_ids)
    unless card_ids.is_a?(Array)
      add_card(card_ids)
    else
      card_ids.each do |card_id|
        self.add_card(card_id)
      end
    end
    self
  end

  def add_card(card_id)
    card_slot = card_slots.find_by(card_id: card_id)
    if card_slot
      card_slot.quantity += 1
      card_slot.save
    else
      self.card_slots.create(card_id: card_id)
    end
  end


  def total_cards_in(status)
    self.card_slots.where(status: status).inject(0) { |acc, obj| acc + obj.quantity}
  end

  def ensure_right_number_of_cards
    return nil if self.is_prototype
    total = self.total_cards_in("main_board")
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
