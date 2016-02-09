class Api::CardSetsController < ApplicationController

  def index
    @sets = CardSets.all
    render json: @sets, status: 200
  end

end
