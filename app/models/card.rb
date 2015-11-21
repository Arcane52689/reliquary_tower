class Card < ActiveRecord::Base
  VALID_COLORS = ['Blue', 'White', 'Black', 'Green', 'Red']
  COLOR_DICT = {
    W: "White",
    U: "Blue",
    B: "Black",
    R: "Red",
    G: "Green"
  }


  has_many :card_slots
  has_many :decks, through: :card_slots, as: :deck

  validates :name, :mana_cost, :cmc, :rarity, :multiverse_id, presence: true
  validates :card_text, presence: true, allow_blank: true
  validate :valid_colors

  before_save :determine_can_be_commander
  before_save :parse_color_identity



  def valid_colors
    self.colors.each do |color|
      unless VALID_COLORS.include?(color)
        self.errors[:colors] << "#{color} is not a valid color. Must be one of the following: #{VALID_COLORS.join(", ")}"
      end
    end
  end


  def is_legendary?
    self.supertypes.include?("Legendary")
  end

  def is_creature?
    self.supertypes.include?("Creature")
  end

  def is_legendary_creature?
    self.is_legendary? && self.is_creature?
  end

  def determine_can_be_commander
    self.can_be_commander ||= self.is_legendary_creature?
    true
  end

  def parse_color_identity
    self
  end


end
