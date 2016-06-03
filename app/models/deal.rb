class Deal < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :fuente, presence: true
  validates :producto, presence: true
  validates :probabilidad, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
