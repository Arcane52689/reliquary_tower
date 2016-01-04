


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
    acceptable_types = ["Artifact", "Creature", "Enchantment", "Instant", 'Land', "Planeswalker", "Sorcery", "Tribal"]
    join_statement = "LEFT OUTER JOIN taggings ON taggings.taggable_id = cards.id"
    #Excludes basic lands, joins taggings
    result = Card.joins(join_statement).where("NOT 'Basic' = ANY(supertypes)")
    if params[:card_type]
      # Limits result to certain card types if the parameter is present
      result = result.where("? = ANY(types)", params[:card_type])
    end
    if params[:commander] == "true"
      # If searching for a commander, it lookes for supersets of the given colors, otherwise, it looks for subsets
      result = result.where(can_be_commander: true)
      result = result.find_by_color_identity(params[:included_colors]) if params[:included_colors]
    else
      result = result.find_subsets_of_array_field(:color_identity, params[:included_colors]) if params[:included_colors]
    end
    # matches card_text, though this isn't implemented on the front end yet
    result = result.where('UPPER(card_text) like UPPER(?)', "%#{params[:card_text]}%") if params[:card_text] != ""
    # The tiny leader clause, limits the results to anything
    result = result.where('cmc < 4') if params[:is_tiny_leader] === 'true'
    #Exclude the Un- sets

    result = result.where("card_set_id NOT IN (38, 77)")
    if params[:excluded_card_ids] && params[:excluded_card_ids].any?
      #excludes cards already in the deck as well as cards that have been marked to "exclude"
      excluded_names = Card.find_names_by_ids(params[:excluded_card_ids])
      result = result.where("name NOT IN (?)", excluded_names)
    end
    if params[:category_ids]
      #generates the category ids with an 'OR' clause between them
      query, arguments = Category.query_string_for(params[:category_ids])
      result = result.where(query, *arguments)
    end

    limit = params[:limit].to_i || 10
    result.to_a.uniq(&:name)[0 ... limit]
  end



end
