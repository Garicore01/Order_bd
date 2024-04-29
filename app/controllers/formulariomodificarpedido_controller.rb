class FormulariomodificarpedidoController < ApplicationController
  before_action :require_login

  def index
    
  end

  def new
    @pedido = Pedidos.find_by(idpedido: params[:id])
  end

  def modificar
    pedido_a_modificar = Pedidos.find_by(idpedido: params[:id])

    if params[:botones] == '0'
      redirect_to index_path(id: pedido_a_modificar.nombre), notice: 'Operación cancelada.'
    else
      if pedido_a_modificar.update(pedidos_params)
        redirect_to index_path(id: pedido_a_modificar.nombre), notice: 'Información del pedido actualizada correctamente.'
      else
        render :index, notice: 'Error al actualizar el pedido.'
      end
    end
  end

  private

  def pedidos_params
    params.require(:pedidos).permit(:nombre, :fecharecogida, :telefono, :productos)
  end
end
