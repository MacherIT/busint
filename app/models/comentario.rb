class Comentario < ActiveRecord::Base
  belongs_to :user
  belongs_to :accion
  
  default_scope -> { order(created_at: :asc) }

  validates :user_id, presence: true
  validates :accion_id, presence: true
  validates :texto, presence: true, length: { maximum: 1000 }
end
