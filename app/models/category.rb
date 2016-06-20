class Category < ActiveRecord::Base
  has_many :payments
end
