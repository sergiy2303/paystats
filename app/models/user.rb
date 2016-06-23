class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :payments

  validates_numericality_of :default_category_id, greater_than_or_equal_to: 1, only_integer: true
  validates :first_name, :last_name, presence: true

  def default_category
    Category.default_category_for(self)
  end
end
