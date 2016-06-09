class ParticipacionsController < ApplicationController

  def create
    deal = Deal.find(params[:deal_id])
    deal.invitar(User.find(params[:user_id]))
    redirect_to edit_deal_path(deal)
  end

  def destroy
    user = Participacion.find(params[:id]).user
    deal = Participacion.find(params[:id]).deal
    deal.echar(user)
    redirect_to edit_deal_path(deal)
  end

end
