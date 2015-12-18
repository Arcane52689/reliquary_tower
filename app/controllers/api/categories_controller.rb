class Api::CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    render json: @category
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      render json: @category, status: 200
    else
      render json: {errors: @category.errors.full_messages}, status:422
    end
  end


  def index
    @categories = Category.all
    render json: @categories, eachserializer: CategorySerializer
  end

  def category_params
    params.permit(:name)
  end

end
