class Api::CardsController < ApplicationController

  def show
    @card = Card.find(params[:id])
    render json: @card
  end

  def find_by
    @card = Card.find_by("UPPER(name) = UPPER(?)", params[:name])
    if @card
      render json: @card, status: 200
    else
      message = params[:name] + " was not found"
      render json: {error: message}, status: 404
    end
  end

  def commanders
    @cards = CardSuggestionService.commander([], [])

    render json: @cards, each_serializer: CardSerializer
  end


  def search

    @cards = CardSuggestionService.search_by_name(search_params)

    render json: @cards
  end

  def suggestions

    @cards = CardSuggestionService.suggest(suggestion_params)
    render json: @cards
  end

  def search_params
    params.permit(:name, :card_text, :orderBy, :limit)
  end

  def suggestion_params

    params.permit(:card_text, :limit, :commander, :is_tiny_leader, :card_type, included_colors: [], category_ids: [], excluded_card_ids: [])
  end


end
