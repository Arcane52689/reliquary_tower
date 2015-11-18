class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= Session.find_user_by_token(session[:session_token])
    return @current_user
  end

  def logged_in?
    !!current_user
  end

  def login(user)
    session_token = user.sessions.create.token
    session[:session_token] = session_token
  end

  def new
    @model = get_class.new
    render :new
  end

  def create
    @model = get_class.new(model_params)
    if @model.save
      # render json: @model, status: 200
      redirect_to user_url(@model)
    else
      render json: {errors: @model.errors.full_messages}, status: 422
    end
  end

  def update
    @model = get_class.find(params[:id])
    if @model.update(model_params)
      render json: @model, status: 200
    else
      render json: {errors: @model.errors.full_messages}, status: 422
    end
  end

  def edit
    @model = get_class.find(params[:id])
    render :edit
  end

  def index
    @models = get_class.all
  end

  def destroy
    @model = get_class.find(params[:id])
    if @model.destroy
      render json: @model, status: 200
    else
      render json: {errors: 'WTF went wrong? '}
    end
  end

end
