class Api::DecksController < ApplicationController



  def show
    @deck = Deck.includes(card_slots: :card).find(params[:id])
    render json: @deck
  end

  def create
    @deck = current_user.decks.new(deck_params)
    byebug
    if @deck.save
      render json: @deck, status: 200
    else
      render json: @deck.errors.full_messages, status: 422
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
      params.permit(:name, taggings: [], card_slots: [:card_id, :location, :quantity])
    end



end
