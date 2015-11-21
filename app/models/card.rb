class Card < ActiveRecord::Base
  VALID_COLORS = ['Blue', 'White', 'Black', 'Green', 'Red']
  COLOR_DICT = {
    "W" => "White",
    "U" => "Blue",
    "B" => "Black",
    "R" => "Red",
    "G" => "Green"
  }
  COLOR_REGEX = /({\w}|{\w\/\/\w})/

  has_many :card_slots
  has_many :decks, through: :card_slots, as: :deck

  validates :name, :cmc, :rarity, :multiverse_id, presence: true
  validates :mana_cost, presence: true, allow_blank: true
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


  def is_basic?
    self.supertypes.include?("Basic")
  end

  def is_legendary?
    self.supertypes.include?("Legendary")
  end

  def is_creature?
    self.types.include?("Creature")
  end

  def is_legendary_creature?
    self.is_legendary? && self.is_creature?
  end

  def determine_can_be_commander
    self.can_be_commander ||= self.is_legendary_creature?
    true
  end

  def parse_color_identity
    [self.mana_cost, self.card_text].each do |text|
      text.scan(COLOR_REGEX) do |mana_symbol|
        mana_symbol[0].scan(/\w/) do |color|
          self.color_identity << COLOR_DICT[color[0]]
        end
      end
    end
    self.color_identity.uniq!
  end



end
