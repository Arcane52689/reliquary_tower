class Api::BansController < ApplicationController


  def index
    @bans = Ban.all
  end

  def create
    @ban = Ban.new(ban_params)
    if @ban.save
      render json: @ban, status: 200
    else
      render json: @ban.errors.full_messages, status: 422
  end

  def update

  end

  def destroy

  end

  def show

  end

  def ban_params
    params.require(:ban).permit(:card_name, :format)
  end


end
