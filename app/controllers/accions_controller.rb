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
    @accion = @deal.accions.build(acciones_params)
    @accion.user = User.find_by(id: params[:user_id])
    if @accion.save
      flash[:success] = "Acción guardada"
      actualizar_deal
      redirect_to deal_path(@deal)
    else
      flash[:danger]= "No pudo ser guardada la acción."
      redirect_to nueva_accion_deal_path(@deal)
    end
  end

  def destroy
    redirect_to root_url and return unless @accion = Accion.find_by(id: params[:id])
    if @accion.destroy
      flash[:success] = "Acción eliminada."
      redirect_to @accion.deal
    else
      flash[:danger] = "La acción no pudo ser eliminada."
      render 'edit'
    end
  end

  def edit
    @accion = Accion.find_by(id: params[:id])
  end
  
  def update
    redirect_to root_url and return unless @accion = Accion.find_by(id: params[:id])
    if @accion.update_attributes(acciones_params)
      flash[:success] = "Acción actualizada."
      actualizar_deal
      redirect_to @accion.deal
    else
      render 'edit'
    end
  end

  private
  
    # Devuelve los parametros permitidos
    def acciones_params
      params.require(:accion).permit(:medio, :salida, :resultado, :comentario, :fecha, :hecha)
    end

    # Actualiza el estado del deal correspondiente
    def actualizar_deal
      @accion.deal.actualizar_estado
      flash[:info] = "Estado del deal actualizado."
    end
      

end
