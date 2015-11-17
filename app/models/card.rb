class Card < ActiveRecord::Base
  VALID_COLORS = ['Blue', 'White', 'Black', 'Green', 'Red']

  validates :name, :mana_cost, :cmc, :rarity, presence: true
  validate :valid_colors




  def valid_colors
    self.colors.each do |color|
      unless VALID_COLORS.include?(color)
        self.errors[:colors] << "#{color} is not a valid color. Must be one of the following: #{VALID_COLORS.join(", ")}"
      end
    end
  end

end
