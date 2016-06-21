class AddDefaultCategoryForUser < ActiveRecord::Migration
  def change
    add_column :users, :default_category_id, :integer, index: true
  end
end
