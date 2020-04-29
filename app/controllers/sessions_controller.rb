class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully"
      redirect_to user
    else
      flash.now[:alert] = "Login details don't match"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "User logged out successfully"
    redirect_to root_path
  end

end
