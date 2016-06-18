class Empresa < ActiveRecord::Base
  has_many :deals
  validates :nombre, presence: true
  validates :ciudad, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true
end
