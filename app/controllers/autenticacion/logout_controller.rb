class Autenticacion::LogoutController < ApplicationController
    def new
    end
  
    # Método que se encarga de gestionar el logout.
    def logout
        session[:usuario_id] = nil
        redirect_to login_path
    end
  end
  