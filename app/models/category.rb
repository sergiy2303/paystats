class Category < ActiveRecord::Base
  has_many :payments
  belongs_to :user
  scope :default_category_for, -> (user) { find_by(id: user.default_category_id) || first }
  scope :all_categories_for, -> (user) { where(user_id: user.id).or(public_categories) }
  scope :public_categories, -> { where(public: true) }
  validates :name, length: { maximum: 50 }
end
