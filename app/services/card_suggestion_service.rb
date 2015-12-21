


class CardSuggestionService


  def self.commander(colors, categories)
    result = Card.where( can_be_commander: true)
    result = result.joins(:taggings).find_by_color_identity(colors) if colors.any?
    result = result.where("category_id IN (?)", categories) if categories.any?
    result.to_a.uniq(&:name)
  end

  def self.tiny_leader(colors, categories)
    self.commander(colors, categories).where("cmc < 4")
  end


  def self.search_by_name(params)
    Card.where('UPPER(name) like UPPER(?)', "%#{params[:name]}%").order(params[:orderBy]).limit(params[:limit])
  end



  def self.suggest(params)
    join_statement = "LEFT OUTER JOIN taggings ON taggings.taggable_id = cards.id"
    result = Card.joins(join_statement).all
    byebug
    result = result.where(can_be_commander: true) if params[:commander]
    result = result.where('UPPER(name) like UPPER(?)', "%#{params[:card_text]}%")
    result = result.find_by_color_identity(params[:included_colors]) if params[:included_colors]
    result.where('cmc < 4') if params[:is_tiny_leader]
    if params[:category_ids]
      byebug
      query, arguments = Category.query_string_for(params[:category_ids])
      result = result.where(query, *arguments)
    end

    limit = params[:limit].to_i || 10
    result = result.limit(limit)
    result

  end



end
