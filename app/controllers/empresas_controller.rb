class EmpresasController < ApplicationController
  before_action :logged_in_user
  
  def index
    @empresas = Empresa.paginate(page: params[:page])
  end
  
  def destroy
    redirect_to root_url and return unless @empresa = Empresa.find_by(id: params[:id])
    if current_user.admin?
      @empresa.destroy
      flash[:success] = 'La empresa fue eliminada.'
      redirect_to empresas_path
    else 
      flash[:danger] = "Solo los admins pueden eliminar empresas."
      redirect_to @empresa
    end
  end
  
  def show
    redirect_to root_url and return unless @empresa = Empresa.find_by(id: params[:id])
    @deal = @empresa.deals.order(updated_at: :desc).first
    @deals = @empresa.deals.count
  end

  def new
  end
  
  def edit
  end

end
