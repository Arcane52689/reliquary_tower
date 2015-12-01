class Api::SessionsController < ApplicationController



  def create
    user = User.find_by_credentials(
      params[:user][:email_or_username],
      params[:user][:password]
    )

    if user
      login(user)
      render json: user, status: 200
    else
      render json: {error: "invalid login credentials"}, status: 422
    end
  end

  def destroy
    current_session = Session.find_by(token: session[:session_token])
    session[:session_token] = nil
    current_session.destroy!
    render json: {success: "logged out"}, status: 200;
  end

end
