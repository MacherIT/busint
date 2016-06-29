class EmpresasController < ApplicationController
  before_action :set_empresa, only: [:show, :edit, :update, :destroy, :deals, :nuevo_contacto]
  before_action :logged_in_user
  
  def index
    @empresas = Empresa.paginate(page: params[:page])
  end
  
  def destroy
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
  end

  def update
    if @empresa.update_attributes(empresa_params)
      flash[:success] = "Los datos de la empresa fueron actualizados."
      redirect_to @empresa
    else
      flash[:danger] = "No se pudieron actualizar los datos de la empresa"
      render 'edit'
    end
  end 

  def deals
    @deals = @empresa.deals
  end

  def nuevo_contacto
    @contacto = @empresa.contactos.build
    render new_contacto_path
  end

  def contacto
    render 'contactos/create'
  end

  private 
  
    def empresa_params
      params.require(:empresa).permit(:nombre_legal, :tel, :email, :dir, :ciudad, :nombre)
    end
    
    def set_empresa
      redirect_to root_url and return unless @empresa = Empresa.find_by(params[:id])      
    end
end
