class Api::BansController < ApplicationController


  def index
    @bans = Ban.all
    render json: @bans
  end

  def create
    @ban = Ban.new(ban_params)
    if @ban.save
      render json: @ban, status: 200
    else
      render json: {error: @ban.errors.full_messages}, status: 422
    end
  end

  def update
    @ban = Ban.find(params[:id])
    if @ban.update(ban_params)
      rener json: @ban, status: 200
    else
      render json: @ban.errors.full_messages, status: 422
    end
  end

  def destroy

  end

  def show

  end

  def ban_params
    params.require(:ban).permit(:card_name, :format)
  end


end
