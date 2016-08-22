class ComentariosController < ApplicationController
  before_action :logged_in_user

  def create
    if not @comentario = current_user.comentarios.create(comentarios_params)
      flash.now[:danger] = "El comentario no pudo ser guardado."
    end
    respond_to do |format|
      format.html { redirect_to deal_path(@comentario.accion.deal) }
      format.js
    end
  end

  def update
    unless @comentario = current_user.comentarios.find_by(accion_id: params[:accion_id])
      redirect_to deal_path(@comentario.accion.deal)
    end
    @comentario.texto = comentarios_params[:texto]
    unless @comentario.save
      flash.now[:danger] = "El comentario no pudo ser actualizado."
    end
    respond_to do |format|
      format.html { redirect_to deal_path(@comentario.accion.deal) }
      format.js
    end
  end

  def destroy
    unless @comentario = current_user.comentarios.find_by(accion_id: params[:accion_id])
      redirect_to deal_path(@comentario.accion.deal)
    end
    unless @comentario.destroy
      flash.now[:danger] = "El comentario no pudo ser borrado."
    end
    respond_to do |format|
      format.html { redirect_to deal_path(@comentario.accion.deal) }
      format.js
    end
  end

  private
    
    # Devuelve los parametros permitidos
    def comentarios_params
      params.require(:comentario).permit(:accion_id, :texto)
    end


end
