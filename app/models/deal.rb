# -*- coding: utf-8 -*-
class Deal < ActiveRecord::Base
  belongs_to :user 
  belongs_to :producto
  has_many :participacions, class_name: "Participacion", 
                            foreign_key: "deal_id",
                            dependent: :destroy
  has_many :cousers, through: :participacions, source: :user
  has_many :accions, class_name: "Accion",
                     foreign_key: "deal_id",
                     dependent: :destroy
  default_scope -> { order(updated_at: :desc) }
  validates :user_id, presence: true
  validates :producto_id, presence: true
  validates :fuente, presence: true
  validates :probabilidad, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true
  validates :empresa, presence: true
  validates :estado, inclusion: { in: ["Ganado", "Perdido", "En progreso"], message: "El estado tiene que ser uno de los siguentes: 'Ganado', 'Perdido' o 'En progreso'."}
  
  # Invita a un companero al deal
  def invitar(otro_user)
    if user != otro_user and not cousers.include?(otro_user)
      participacions.create(user_id: otro_user.id)
    end
  end
  
  # Saca a un companero del deal
  def echar(otro_user)
    participacions.find_by(user_id: otro_user.id).destroy
  end
  
  # Devuelve true si el deal tiene a un usuario trabajando en el
  def participa?(otro_user)
    cousers.include?(otro_user)
  end

  # Acomoda el estado del deal de acuerdo a la ultima accion
  def actualizar_estado
    last_accion = accions.first
    estado = case last_accion.resultado
               when "Sigue" then "En progreso"
               when "Posterga" then "En progreso"
               when "Cancela" then "Perdido"
               when "Contrata" then "Ganado"
             end
  end

  private

end


