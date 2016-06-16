# -*- coding: utf-8 -*-
class AccionsController < ApplicationController
  before_action :logged_in_user

  def new
  end

  def create
    if not @deal = Deal.find_by(id: params[:deal_id])
      flash[:danger] = "No existe ese deal."
      redirect_to root_url and return
    end
    @acc = @deal.accions.build(acciones_params)
    @acc.user = User.find_by(id: params[:user_id])
    if @acc.save
      flash[:success] = "Acción guardada"
      actualizar_deal
      redirect_to deal_path(@deal)
    else
      flash[:danger]= "No pudo ser guardada la acción."
      redirect_to nueva_accion_deal_path(@deal)
    end
  end

  def destroy
  end

  def edit
  end
  
  def update
  end

  private
  
    # Devuelve los parametros permitidos
    def acciones_params
      params.require(:accion).permit(:medio, :salida, :resultado, :comentario, :fecha, :hecha)
    end

    # Actualiza el estado del deal correspondiente
    def actualizar_deal
      @acc.deal.actualizar_estado
      flash[:info] = "Estado del deal actualizado."
    end
      

end
