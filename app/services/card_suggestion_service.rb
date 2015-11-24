


class CardSuggestionService


  def commander(colors, categories)
    result = Card.find_by_color_identity(colors).joins(:taggings).where( can_be_commander: true)
    result.where("category_id IN (?)", categories) if categories.any?
    result
  end

  def tiny_leader(colors, categories)
    commander(colors, categories).where("cmc < 4")
  end



end
