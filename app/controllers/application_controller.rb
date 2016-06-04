class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  
    # Confirma que el usuario esta logueado
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Por favor, logueate."
        redirect_to loguearse_url
      end
    end

end
