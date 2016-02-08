class Api::DecksController < ApplicationController



  def show
    @deck = Deck.includes(card_slots: :card).find(params[:id])
    render json: @deck
  end

  def create
    @deck = current_user.decks.new(deck_params)
    if @deck.save
      @deck.card_slots.includes(:card)
      render json: @deck, status: 200
    else
      render json: {error: @deck.errors.full_messages}, status: 422
    end
  end

  def update
    @deck = current_user.decks.includes(card_slots: :card).find(params[:id])
    if @deck.update(deck_params)
      render json: @deck, status:200
    else
      render json: {error: @deck.errors.full_messages}, status: 422
    end
  end

  def destroy

  end

  def index
    @decks = Deck.all
    render json: @decks, each_serializer: DeckInfoSerializer
  end

  private

    def deck_params
      params.require(:deck).permit(:name, :format, category_ids: [], card_slots: [:id, :card_id, :location, :quantity])
    end



end
