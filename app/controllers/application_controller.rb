class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.


  protect_from_forgery with: :null_session

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

  

end
