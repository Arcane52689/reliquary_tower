class Api::DecksController < ApplicationController



  def show

  end

  def create

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
