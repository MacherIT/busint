class ContactosController < ApplicationController
  before_action :set_contacto, only: [:show, :edit, :update, :destroy]

  def index
    @contactos = Contacto.all
  end

  def show
  end


  def new
  end

  def edit
  end

  def create
    @contacto = Contacto.new(contacto_params)
    respond_to do |format|
      if @contacto.save
        flash[:success] = "El nuevo contacto fue guardado"
        redirect_to @contacto
      else
        flash[:danger] = "El contacto no pudo ser guardado"
        reder 'new'
      end
    end
  end

  def update
    respond_to do |format|
      if @contacto.update_attributes(contacto_params)
        flash[:success] = "Los datos de la empresa fueron actualizados."
        redirect_to @contacto
      else
        flash[:danger] = "No se pudieron actualizar los datos del contacto"
        render 'edit'
      end
    end
  end

  # DELETE /contactos/1
  # DELETE /contactos/1.json
  def destroy
    @contacto.destroy
    respond_to do |format|
      format.html { redirect_to contactos_url, notice: 'Contacto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def deals
    @deals = @contacto.deals
  end
  
  def nuevo_deal
  end
  
  def deal
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contacto
      @contacto = Contacto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contacto_params
      params.require(:contacto).permit(:nombre, :apellido, :cargo, :tel, :dir, :email, :ciudad, :bday, :empresa_id, :familia, :comentarios)
    end
end
