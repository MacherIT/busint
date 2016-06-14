class Accion < ActiveRecord::Base
  belongs_to :deal
  default_scope -> { order(updated_at: :desc) }
  validates :deal_id, presence: true
  validates :efect, presence: true, inclusion: { in: ["Exitosa", "Neutra", "Final"] }
  validates :medio, presence: true, inclusion: { in: ["Llamada", "Visita", "Social Media", "Email"] }
end
