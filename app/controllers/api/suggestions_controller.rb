class API::SuggestionsController < ApplicationController


  def all_commanders
    @cards = CardSuggestionService.commander([], [])
  end

  def all_tiny_leaders
    @cards = CardSuggestionService.tiny_leader([], [])
  end





end
