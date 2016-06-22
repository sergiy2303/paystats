class AddImageForPayment < ActiveRecord::Migration
  def change
    add_column :payments, :image, :string
  end
end
