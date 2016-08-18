class StaticPagesController < ApplicationController

  def inicio
    if logged_in?
      user_id = current_user.id
      @eventos = Accion.where(user_id: user_id)
    end
  end

  def form_visita
  end

  def form_cliente
  end

  def ayuda
  end

end
