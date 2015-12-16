class Card < ActiveRecord::Base
  VALID_COLORS = ['Blue', 'White', 'Black', 'Green', 'Red']
  COLOR_DICT = {
    "W" => "White",
    "U" => "Blue",
    "B" => "Black",
    "R" => "Red",
    "G" => "Green"
  }
  COLOR_REGEX = /({\w}|{\w\/\w})/

  has_many :card_slots
  has_many :decks, through: :card_slots, as: :deck
  has_many :taggings, as: :taggable

  belongs_to :card_set

  validates :name, :cmc, :rarity, :type_string, :multiverse_id, presence: true
  validates :mana_cost, presence: true, allow_blank: true
  validates :card_text, presence: true, allow_blank: true
  validate :valid_colors

  before_save :determine_can_be_commander
  before_save :parse_color_identity

  def self.find_by_color(color)
    self.find_by_single_item_in_array_field(:colors, color)
  end

  def self.find_by_multicolor(colors)
    self.find_by_multiple_items_in_array_field(:colors, colors)
  end

  def self.find_by_color_identity(colors)
    self.find_by_multiple_items_in_array_field(:color_identity, colors)
  end

  def self.find_by_single_item_in_array_field(field, item)
    self.where("? = ANY (#{field})", item)
  end

  def self.find_by_multiple_items_in_array_field(field, arr)
    self.where("#{field} @> ARRAY[?]::varchar[]", arr)
  end


  def self.create_from_json(data)

    new_card = Card.new( {
      mana_cost: data["manaCost"] || "",
      name: data["name"],
      cmc: data["cmc"] || 0,
      colors: data["colors"] || [],
      supertypes: data["supertypes"] || [],
      types: data["types"] || [],
      subtypes: data["subtypes"] || [],
      card_text: data["text"] || "",
      multiverse_id: data["multiverseid"],
      rarity: data["rarity"] || "not listed",
      flavor_text: data["flavor"],
      power: data["power"] || nil,
      toughness: data["toughness"] || nil,
      type_string: data["type"]
    })
    new_card.save
    new_card

  end


  def valid_colors
    self.colors.each do |color|
      unless VALID_COLORS.include?(color)
        self.errors[:colors] << "#{color} is not a valid color. Must be one of the following: #{VALID_COLORS.join(", ")}"
      end
    end
  end


  def find_commander_card_suggestions
    Card.where("color_identity <@ ARRAY[?]::varchar[]", self.color_identity)
  end

  def find_tiny_leader_suggestions
    self.find_commander_card_suggestions.where("cmc < 4")
  end




  def is_colorless?
    self.colors.none?
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

  def can_command?(card)
    self.color_identity.is_superset_of?(card.color_identity)
  end


  def parse_color_identity
    [self.mana_cost, self.card_text].each do |text|
      text.scan(COLOR_REGEX) do |mana_symbol|
        mana_symbol[0].scan(/\w/) do |color|
          self.color_identity << COLOR_DICT[color[0]]
        end
      end
    end
    self.color_identity = self.color_identity.compact.uniq
  end


  def image_url
    "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=#{self.multiverse_id}&type=card"
  end


end

class Array

  def is_superset_of?(arr2)
    superset = true
    arr2.each do |item|

      superset = false unless self.include?(item)
    end
    superset
  end


end
