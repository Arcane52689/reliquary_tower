class SessionsController < ApplicationController

  def new
    render :new
  end


  def create
    user = User.find_by_credentials(
    params[:user][:email_or_username],
    params[:user][:password]
    )
    render :new unless user
    login(user)
    redirect_to root_url
  end

  def destroy
    current_session = Session.find_by(token: session[:session_token])
    session[:session_token] = nil
    current_session.destroy!
    redirect_to new_session_url
  end



end
