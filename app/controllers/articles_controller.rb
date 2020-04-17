class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_parms)

    #render plain: @article.inspect
    if @article.save
      flash[:notice] = "Article was successfully created."
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
      flash[:notice] = "Article was successfully UPDATED."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy

    flash[:notice] = "Article was Deleted Successfully."

    redirect_to articles_path
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_parms
    params.require(:article).permit(:title, :description)
  end
end
