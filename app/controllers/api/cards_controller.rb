class Api::CardsController < ApplicationController

  def show

  end

  def commanders
    @cards = CardSuggestionService.commander([], [])

    render json: @cards, eachserializer: CardSerializer
  end


end
