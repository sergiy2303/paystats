class Category < ActiveRecord::Base
  has_many :payments

  scope :default_category_for, -> (user) { find_by(id: user.default_category_id) || first }
end
