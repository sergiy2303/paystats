class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.date :date
      t.references :user, index: true
      t.references :category, index: true

      t.timestamps null: false
    end
  end
end
