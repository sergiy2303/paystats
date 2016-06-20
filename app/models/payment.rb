class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :amount, presence: true
  validates_numericality_of :amount, greater_than_or_equal_to: 0.01
end
