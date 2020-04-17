class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :description))

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

  end
end
