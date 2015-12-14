class Api::DecksController < ApplicationController



  def show
    @deck = Deck.includes(card_slots: :card).find(params[:id])
    render json: @deck
  end

  def create
    @deck = current_user.decks.new(deck_params)
    # byebug
    if @deck.save
      render json: @deck, status: 200
    else
      render json: @deck.errors.full_messages, status: 422
    end
  end

  def update
    @deck = current_user.decks.find(params[:id])
    @deck.update(deck_params)
    # byebug
    if @deck.update(deck_params)
      render json: @deck, status:200
    else
      render json: {error: @deck.errors.full_messages}, status: 422
    end
  end

  def destroy

  end

  def index

  end

  private

    def deck_params
      params.permit(:name, :format, taggings: [], card_slots: [:card_id, :location, :quantity])
    end



end
