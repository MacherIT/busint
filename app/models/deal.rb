# -*- coding: utf-8 -*-
class Deal < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(updated_at: :desc) }
  validates :user_id, presence: true
  validates :fuente, presence: true
  validates :producto, presence: true, inclusion: { in: ["Web", "App", "Mktg Dig", "Neuro", "Consultoría"], message: "El producto tiene que ser uno de: 'Web', 'App', 'Mktg Dig', 'Neuro', 'Consultoría'" }
  validates :probabilidad, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true
  validates :empresa, presence: true
  validates :estado, inclusion: { in: ["Ganado", "Perdido", "En espera", "Trabajo contratado"], message: "El estado tiene que ser uno de los siguentes: 'Ganado', 'Perdido', 'En espera' o 'Trabajo contratado'."}
end
