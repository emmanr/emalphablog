class SessionsController < ApplicationController

  def new
    if logged_in?
      flash[:danger] = "Already logged in"
      redirect_to user_path(current_user)
    end
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in successfully"
      redirect_to user
    else
      flash.now[:danger] = "Login details don't match"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:warning] = "User logged out successfully"
    redirect_to root_path
  end

end
