class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 6)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_parms)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was successfully created."
      #redirect_to article_path(@article)
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @article.update(article_parms)
      flash[:success] = "Article was successfully UPDATED."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy

    flash[:warning] = "Article was Deleted Successfully."

    redirect_to articles_path
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_parms
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user
      flash[:alert] = "You can edit or delete your own article"
      redirect_to @article
    end
  end
end
