class CategoriesController < ApplicationController
  def index
    @pagy, @categories = pagy(Category.all, items: 5)
  end

  def new
    @category = Category.new
  end

  def show
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "Category was created successfully"
      redirect_to categories_path
    else
      render "new"
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
