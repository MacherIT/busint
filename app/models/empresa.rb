class Empresa < ActiveRecord::Base
  has_many :deals
  validates :nombre, presence: true
end
