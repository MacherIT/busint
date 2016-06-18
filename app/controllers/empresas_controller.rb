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
    @empresa = Empresa.new
  end
  
  def create
    @empresa = Empresa.new(empresa_params)
    if @empresa.save
      flash[:success] = "La nueva empresa fue guardada"
      redirect_to @empresa
    else
      flash[:danger] = "La empresa no pudo ser guardada"
      reder 'new'
    end
  end
    
  
  def edit
    redirect_to root_url and return unless @empresa = Empresa.find_by(params[:id])
  end

  def update
    redirect_to root_url and return unless @empresa = Empresa.find_by(params[:id])
    if @empresa.update_attributes(empresa_params)
      flash[:success] = "Los datos de la empresa fueron actualizados."
      redirect_to @empresa
    else
      flash[:danger] = "No se pudieron actualizar los datos de la empresa"
      render 'edit'
    end
  end 

  private 
  
    def empresa_params
      params.require(:empresa).permit(:nombre_legal, :tel, :email, :dir, :ciudad, :nombre)
    end
end
