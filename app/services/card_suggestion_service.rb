


class CardSuggestionService


  def self.commander(colors, categories)
    result = Card.where( can_be_commander: true).joins(:taggings)
    result = result.find_by_color_identity(colors) if colors.any?
    result.where("category_id IN (?)", categories) if categories.any?
    result
  end

  def self.tiny_leader(colors, categories)
    self.commander(colors, categories).where("cmc < 4")
  end



end
