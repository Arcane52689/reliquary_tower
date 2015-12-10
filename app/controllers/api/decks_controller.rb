class Api::DecksController < ApplicationController



  def show

  end

  def create
    @deck = Deck.new(deck_params)
    if @deck.save
      render json: @deck, status: 200
    else
      render json: @deck.errors.full_messages
    end
  end

  def update

  end

  def delete

  end

  def index

  end

  private

    def deck_params
      params.require(:deck).permit(:name, taggings: [], card_slots: [])
    end



end
