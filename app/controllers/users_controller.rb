# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @deal = @user.deals.build
    @deals = @user.deals.paginate(page: params[:page])
    @participacions = @user.participacions(page: params[:page])
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      @user.send_activation_email
      flash[:info] = "Revisá tu casilla de correo para activar tu cuenta."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Datos actualizados."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Confirma que es el usuario correcto
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

    # Confirma que el usuario es admin
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
      
end
