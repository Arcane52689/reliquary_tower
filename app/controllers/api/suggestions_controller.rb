class Api::SuggestionsController < ApplicationController


  def all_commanders
    @cards = CardSuggestionService.commander([], [])
  end





end
