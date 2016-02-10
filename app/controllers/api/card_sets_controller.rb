class Api::CardSetsController < ApplicationController

  def index
    @sets = CardSet.all
    render json: @sets, status: 200
  end

end
