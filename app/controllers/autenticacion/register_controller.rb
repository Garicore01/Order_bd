class Autenticacion::RegisterController < ApplicationController
    def index
    end
  
    def new
      @usuario = Usuario.new #Creamos una instancia de Usuario, para guardar los datos que nos pasan por el formulario y mandarlo a la BBDD
    end
  
    # Método que se encarga de gestionar el registro de usuarios.
    def create
      @usuario = Usuario.new(user_params) #Obtengo los parametros
  
      # Compruebo que no existe ya un usuario con ese correo electronico.
      if Usuario.find_by(nombre: @usuario.nombre) # Si existe, devuelvo error al cliente
        @usuario.errors.add(:nombre, "ya existe")
        flash[:notice] = "El usuario ya existe!" # Configura el mensaje que deseas mostrar en el pop-up
        render :new, status: :unprocessable_entity
      else
        if @usuario.save # Intento guardar el nuevo usuario en la BBDD
          session[:usuario_id] = @usuario.nombre
            redirect_to root_path
        else
          render :new, status: :unprocessable_entity # Vuelvo a renderizar la pagina de registro, si solo si, ha ocurrido un error al realizar la transacción.
        end
      end
  end
  
    # Método que se encarga de obtener los parametros enviados mediante el formulario.
    private
    def user_params
      params.require(:usuario).permit(:nombre, :password) #Queremos tener un objeto usuario antes que el contenido.
  
    end
  
    # Método para verificar si el usuario ya existe.
    def verificar_credenciales
      nombre = params[:nombre]
      contrasena = params[:contraseña]
  
      # Realiza la consulta a la base de datos
      @cuentaExiste = Usuario.where(nombre: nombre.downcase, contrasena: contrasena).count
      if @cuentaExiste.zero?
        # No se encontraron registros que cumplan con la condición
        @cuentaExiste = 0
      end
      render :existing
    end
  end
  