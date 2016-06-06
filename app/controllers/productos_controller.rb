class ProductosController < ApplicationController
  before_action :logged_in_user

  def show
    @producto = Producto.find(params[:id])
    @deals = @producto.deals
  end

  def index
    @productos = Producto.all
  end

end
