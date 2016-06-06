class Producto < ActiveRecord::Base
  has_many :deals
  validates :nombre, presence: true, uniqueness: { case_sensitive: false }
end
