class API::SuggestionsController < ApplicationController


  def commanders
    @cards = CardSuggestionService.commander(params[:card][:colors], params[:card][:categories])
  end

  def tiny_leaders
    @cards = CardSuggestionService.tiny_leader(params[:card][:colors], params[:card][:categories])
  end





end
