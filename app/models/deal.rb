class Deal < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(updated_at: :desc) }
  validates :user_id, presence: true
  validates :fuente, presence: true
  validates :producto, presence: true
  validates :probabilidad, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true
  validates :empresa, presence: true
end
