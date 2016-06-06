class DealsController < ApplicationController
  before_action :logged_in_user

  def create
    @deal = current_user.deals.build(deal_params)
    if @deal.save
      flash[:succcess] = "Tu deal fue guardado"
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
  end

  def show
  end

  def update
  end
  
  private
  
    def deal_params
      params.require(:deal).permit(:fuente, :producto, :empresa, :probabilidad)
    end

end
