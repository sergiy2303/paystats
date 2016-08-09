module CategoriesHelper
  def all_categories
    @all_categories ||= Category.all_categories_for(current_user)
  end
end
