class UsersController < ApplicationController
  def index
    @pagy, @users = pagy(User.all, items: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to alphablog #{@user.username}"
      redirect_to articles_path
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @pagy, @user_articles = pagy(@user.articles.all, items: 5)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "your account was updated successfully"
      redirect_to articles_path
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
