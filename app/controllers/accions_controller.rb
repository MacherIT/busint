# -*- coding: utf-8 -*-
class AccionsController < ApplicationController
  before_action :logged_in_user
#  after_action  :actualizar_deal, only: [:create, :destroy, :update]

  def new
  end

  def create
    if not @deal = Deal.find_by(params[:deal_id])
      flash[:danger] = "No existe ese deal."
      redirect_to root_url and return
    end
    @acc = @deal.accions.new(acciones_params)
    if @acc.save
      flash[:success] = "Acción guardada"
      redirect_to deal_path(@deal)
    else
      flash[:danger]= "No pudo ser guardada la acción."
      redirect_to nueva_accions_deal_path(@deal)
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
      params.require(:accion).permit(:medio, :salida, :efect, :causa)
    end

    # Actualiza el estado del deal correspondiente
    def actualizar_deal
      if @acc.nil?
        return
      end
      actualizar_estado(@acc.deal)
    end
      

end
