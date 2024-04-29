class FormularionuevopedidoController < ApplicationController
    before_action :require_login
  
    def new
        @newPedido = Pedidos.new
    end

    def newPedido
        #Obtengo el nombre del usuario.
        usuario = Usuario.find_by(nombre: session[:usuario_id])
        @newPedido = Pedidos.new(pedido_params)

        if @newPedido.save 
            redirect_to root_path, notice: 'Pedido añadido con exito!'
        else
            render :new, alert: @newPedido.errors.full_message.join(', ')
        end

    end

    private
    def pedido_params
        params.require(:pedidos).permit(:nombre, :fecharecogida, :productos, :telefono)
    end

    



end
