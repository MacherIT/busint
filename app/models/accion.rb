class Accion < ActiveRecord::Base
  belongs_to :deal
  belongs_to :user
  default_scope -> { order(fecha: :desc) }
  validates :deal_id, presence: true
  validates :user_id, presence: true
  validates :resultado, presence: true, inclusion: { in: ["Sigue", "Posterga", "Cancela", "Contrata"] }
  validates :medio, presence: true, inclusion: { in: ["Llamada", "Visita", "Social Media", "Email"] }
  validates :fecha, presence: true
end
