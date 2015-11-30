class Api::SessionsController < ApplicationController



  def create
    user = User.find_by_credentials(
      params[:user][:email_or_username],
      params[:user][:password]
    )

    if user
      render json: user, status: 200
    else
      render json: "invalid login credentials"
    end
  end

  def destroy
    byebug
    current_session = Session.find_by(token: session[:session_token])
    session[:session_token] = nil
    current_session.destroy!
    render json: {success: "logged out"}, status: 200;
  end

end
