class AddNotesForPayment < ActiveRecord::Migration
  def change
    add_column :payments, :notes, :text
  end
end
