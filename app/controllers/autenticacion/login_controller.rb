class Autenticacion::LoginController < ApplicationController

    def new
      session[:previous_url] = request.referer
      @error = false
    end
  
    # Método que se encarga de gestionar la lógica para iniciar sesión en el sistema.
    def create
        @usuario = Usuario.find_by("nombre = :nombre", {nombre: params[:nombre]}) # Busco el usuario cuyo correo es el que me mandan.
        #pp @usuario # Para imprimir por pantalla el usuario.
  
        if @usuario&.authenticate(params[:password ]) #Utilizamos el metodo de has_secure_password. El & es para que realice el checkeo SOLO si existe el usuario.
            session[:usuario_id] = @usuario.nombre
            redirect_to root_path
        else
            @error = true
            flash[:notice] = "Login invalido!" # Configura el mensaje que deseas mostrar en el pop-up
            redirect_to login_path, notice: 'Login invalido'
        end
  
    end
  
    def destroy
        redirect_to root_path, notice: 'Sesión cerrada correctamente.'
    end
  
  end
  