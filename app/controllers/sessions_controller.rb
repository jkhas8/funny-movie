class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if not user
      user = User.create(email: params[:email], password: params[:password])
    end
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in sucessfully!"
    else
      redirect_to root_url, alert: "Password is invalid"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out sucessfully!"
  end
end
