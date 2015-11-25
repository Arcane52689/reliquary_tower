class UsersController < ApplicationController
  CLASS = User

  def new
    @model = User.new
    render :new
  end

  def create
    @model = User.new(model_params)
    if @model.save
      # render json: @model, status: 200
      redirect_to root_url
    else
      render json: {errors: @model.errors.full_messages}, status: 422
    end
  end

  def update
    @model = User.find(params[:id])
    if @model.update(model_params)
      render json: @model, status: 200
    else
      render json: {errors: @model.errors.full_messages}, status: 422
    end
  end

  def edit
    @model = User.find(params[:id])
    render :edit
  end

  def index
    @models = User.all
  end

  def destroy
    @model = User.find(params[:id])
    if @model.destroy
      render json: @model, status: 200
    else
      render json: {errors: 'WTF went wrong? '}
    end
  end

  def model_params
    params.require(:user).permit(:username, :email, :password)
  end
end
