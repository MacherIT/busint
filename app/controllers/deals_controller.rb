class DealsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:destroy, :edit, :update]

  def create
    @deal = current_user.deals.build(deal_params)
    if @deal.save
      flash[:success] = "Tu deal fue guardado"
    else
      flash[:danger] = "Tu deal no pudo ser guardado"
    end
    redirect_to current_user
  end
  
  def edit
  end

  def index
  end

  def destroy
    @deal.destroy
    flash[:success] = "El deal fue borrado."
    redirect_to request.referrer || root_url
  end

  def show
  end

  def update
    if @deal.update_attributes(deal_params)
      flash[:success] = "Deal actualizado."
    end
    render 'edit'
  end
  
  private
  
    def deal_params
      params.require(:deal).permit(:fuente, :producto_id, :empresa, :probabilidad, :estado)
    end

    def correct_user
      if current_user.admin?
        @deal = Deal.find_by(id: params[:id])
        flash[:danger] = "No existe ese Deal" if @deal.nil?
      else
        @deal = current_user.deals.find_by(id: params[:id])
      end
      redirect_to root_url if @deal.nil?
    end

end
