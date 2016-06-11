# -*- coding: utf-8 -*-
class ParticipacionsController < ApplicationController
  before_action :logged_in_user

  def create
    @deal = Deal.find(params[:deal_id])
    redirect_to root_url and return unless (usuario_participa? or current_user.admin?)
    @user_id = params[:user_id]
    @deal.invitar(User.find(@user_id))
    respond_to do |format|
      format.html { redirect_to edit_deal_path(@deal) }
      format.js
    end
  end

  def destroy
    @user = Participacion.find(params[:id]).user
    @deal = Participacion.find(params[:id]).deal
    if particip_propia?
      flash[:info] = "No podés eliminarte de un deal vos mismo."
      respond_to do |format|
        format.html { redirect_to edit_deal_path(@deal) and return }
        format.js
      end
    end
    redirect_to root_url and return unless (usuario_participa? or current_user.admin?)
    @deal.echar(@user)
    respond_to do |format|
      format.html { redirect_to edit_deal_path(@deal) }
      format.js
    end
  end

  private
  
    def usuario_participa?
      @deal.user == current_user or @deal.cousers.include?(current_user)
    end

    def particip_propia?
      @user == current_user
    end

end
