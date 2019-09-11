class ArticlesController < ApplicationController
  before_action :set_articles, only: [:edit, :update, :show, :destroy]
  before_action :require_user, exccept: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @pagy, @articles = pagy(Article.all, items: 10)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article has been updated"
      redirect_to article_path(@article)
    else
      render "edit"
    end
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:success] = "Article was succesfully created"
      redirect_to article_path(@article)
    else
      render "new"
    end
  end

  def destroy
    @article.destroy

    flash[:danger] = "Article was successfully deleted "
    redirect_to articles_path
  end

  def show
  end

  private

  def set_articles
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user
      flash[:danger] = "you can only edit or delete your own article"
      redirect_to root_path
    end
  end
end
