class Contacto < ActiveRecord::Base
  include PeopleHelper

  belongs_to :empresa
  has_many :deals
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  def nombre_completo
    nombre + " " + apellido
  end
  
end
