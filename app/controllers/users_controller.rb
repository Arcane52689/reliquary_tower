class UsersController < ApplicationController
  CLASS = User

  def get_class
    User
  end

  def create
    @model = get_class.new(model_params)
    if @model.save
      # render json: @model, status: 200
      login(@model)
      redirect_to new_user_url
    else
      render json: {errors: @model.errors.full_messages}, status: 422
    end
  end


  def model_params
    params.require(:user).permit(:username, :email, :password)
  end
end
