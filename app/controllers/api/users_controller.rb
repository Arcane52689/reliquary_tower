class Api::UsersController < ApplicationController
  wrap_parameters false


  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      render json: @user, status: 200

    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  def show
    if current_user
      render json: current_user
    else
      render json: {}
    end
  end



  def user_params
    params.permit(:username, :email, :password)
  end
end
