class CategoriesController < ApplicationController
  expose(:category, attributes: :category_params)
  expose(:categories) { current_user.categories }

  def index
  end

  def create
    category.user_id = current_user.id
    if category.save
      redirect_via_turbolinks_to categories_path
    end
  end

  def update
    if category.save
      redirect_via_turbolinks_to categories_path
    else
      render :edit
    end
  end

  def destroy
    category.destroy
    redirect_via_turbolinks_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
