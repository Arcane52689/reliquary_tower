


class CardSuggestionService


  def commander(colors, categories)
    Card.find_by_color_identity(colors).joins(:taggings).where("category_id IN (?)", categories).where(can_be_commander: true)
  end

  def tiny_leader(colors, categories)
    commander(colors, categories).where("cmc < 4")
  end



end
