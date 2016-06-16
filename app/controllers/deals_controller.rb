# -*- coding: utf-8 -*-
class DealsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:destroy, :update, :historial, :nueva_accion]
  before_action :user_editable, only: [:edit]

  def historial
  end

  def nueva_accion
    @deal = Deal.find(params[:id])
    @accion = @deal.accions.build
    render 'accions/new'
  end

  def create
    @deal = current_user.deals.build(deal_params)
    if @deal.save
      flash[:success] = "Tu deal fue guardado"
    else
      flash[:danger] = "Tu deal no pudo ser guardado"
    end
    redirect_to current_user
  end
  
  def new
    @deal = current_user.deals.build
  end

  def edit
  end

  def index
  end

  def destroy
    @deal.destroy
    flash[:success] = "El deal fue borrado."
    redirect_to root_url
  end

  def show
    @deal = Deal.find_by(id: params[:id])
    @accion = @deal.accions.new
  end

  def update
    if @deal.update_attributes(deal_params)
      flash[:success] = "Deal actualizado."
    else
      flash[:danger] = "Tu deal no pudo ser guardado"
    end
    render 'edit'
  end
  
  private
  
    def deal_params
      params.require(:deal).permit(:fuente, :producto_id, :empresa, :probabilidad, :estado, cousers: []).slice(:fuente, :producto_id, :empresa, :probabilidad, :estado)
    end

    # Pasa si el usuario es admin, owner o participante del deal.
    def correct_user
      if current_user.admin?
        @deal = Deal.find_by(id: params[:id])
        flash[:danger] = "No existe ese deal" if @deal.nil?
      else
        @deal = current_user.deals.find_by(id: params[:id]) || current_user.codeals.find_by(id: params[:id])
      end
      redirect_to root_url if @deal.nil?
    end

    # Pasa si el usuario puede editar el deal.
    def user_editable
      if current_user.admin?
        @deal = Deal.find_by(id: params[:id])
        flash[:danger] = "No existe ese deal" if @deal.nil?
      else
        if not @deal = current_user.deals.find_by(id: params[:id]) || current_user.codeals.find_by(id: params[:id])
          if deal = Deal.find_by(id: params[:id])
            redirect_to deal and return
          end
        end
      end
      redirect_to root_url if @deal.nil?
    end

    def actualizar_participantes(cousers)
      cousers.each do |part|
        if compa = User.find_by(id: part)
          if @deal.invitar(compa)
            #flash[:danger] = "Un compañero no pudo ser añadido"
          end
        end
      end
    end


end
