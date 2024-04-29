class ApplicationController < ActionController::Base

    private
    def require_login
        # Redirigo a la pagina de login, si no ha iniciado sesión.
        unless session[:usuario_id]
          puts "Usuario no ha iniciado sesión"
          redirect_to login_path, alert: "Debes iniciar sesión primero"
        else
          # En caso de que tenga la sesión iniciada, obtengo el objeto usuario.
          usuario = Usuario.find_by(nombre: session[:usuario_id])
        end
    end
end
