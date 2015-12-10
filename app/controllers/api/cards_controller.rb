class Api::CardsController < ApplicationController

  def show

  end

  def find_by
    @card = Card.find_by("UPPER(name) = UPPER(?)", params[:name])
    render json: @card
  end

  def commanders
    @cards = CardSuggestionService.commander([], [])

    render json: @cards, eachserializer: CardSerializer
  end


  def search

    @cards = CardSuggestionService.search_by_name(search_params)

    render json: @cards
  end

  def search_params
    params.permit(:name, :card_text, :orderBy, :limit)
  end


end
