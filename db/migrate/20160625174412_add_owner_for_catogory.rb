class AddOwnerForCatogory < ActiveRecord::Migration
  def change
    add_column :categories, :user_id, :integer, index: true
    add_column :categories, :public, :boolean, index: true, default: false
  end
end
