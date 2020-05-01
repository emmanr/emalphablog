class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index]
  before_action :require_same_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.username}. You've registered Successfully."
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def show
    @user_article = @user.articles.paginate(page: params[:page], per_page: 4)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Successfully updated information for user #{@user.username}."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:warning] = "Successfully removed user"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:danger] = "You can only edit your own account"
      redirect_to @user
    end
  end
end
