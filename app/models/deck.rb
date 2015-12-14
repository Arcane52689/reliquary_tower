class Deck < ActiveRecord::Base
  attr_accessor :card_limit, :card_minimum
  @format = "Deck"
  @card_minimum = 0
  @card_limit = Float::INFINITY

  has_many :card_slots, inverse_of: :deck, dependent: :destroy
  has_many :cards, through: :card_slots, as: :card

  belongs_to :user
  has_many :taggings, as: :taggable


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

  def card_slots=(card_slot_hashes)
    new_ids = card_slot_hashes.map { |hash| hash[:id] }.compact
    remove_old_ids(new_ids)
    card_slots.build(card_slot_hashes)
  end

  def remove_old_ids(new_ids)
    id_hash = {}
    self.card_slots.each do |card_slot|
      id_hash[card_slot.id] = false
    end
    new_ids.each do |id|
      id_hash[id] = true
    end

    to_remove_ids = id_hash.select { |k, v| !v }.map { |k| k[0] }
    to_remove_objects = self.card_slots.where('id IN (?)', to_remove_ids)
    to_remove_objects.each do |card_slot|
      card_slot.destroy
    end
  end


  def set_variables
    self.card_limit = self.class.card_limit
    self.card_minimum = self.class.card_minimum
    self.format ||= self.class.format
  end


  def add_cards(card_ids, location="main deck")
    unless card_ids.is_a?(Array)
      add_card(card_ids, location)
    else
      card_ids.each do |card_id|
        self.add_card(card_id, location)
      end
    end
    self
  end

  def add_card(card_id, location="main deck")
    card_slot = card_slots.find_by(card_id: card_id, location: location)
    if card_slot
      card_slot.quantity += 1
      card_slot.save
    else
      self.card_slots.create(card_id: card_id, location: location)
    end
  end


  def total_cards_in(location)
    self.card_slots.where(location: location).inject(0) { |acc, obj| acc + obj.quantity}
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
    if self.card_slots.where(location: 'Commander').count > 1
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
    if self.card_slots.where(location: 'Commander').count > 1
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
