class IndexController < ApplicationController
    before_action :require_login
    before_action :load_pedidos
  
    def index
      filter_pedidos_by_query if params[:query].present?
      filter_pedidos_by_date if params[:fecha].present?
    end
  
    def delete
      pedido = Pedidos.find(params[:idpedido])
      pedido.destroy
      redirect_to root_path, notice: 'Pedido eliminado con éxito'
    end
  
    private
  
    def load_pedidos
      @pedidos = Pedidos.all
    end
  
    def filter_pedidos_by_query
      @pedidos = Pedidos.where("nombre ILIKE ?", "%#{params[:query]}%")
    end
  
    def filter_pedidos_by_date
      date = Date.parse(params[:fecha])
      @pedidos = Pedidos.where("DATE(fecharecogida) = ?", date)
    rescue ArgumentError
      # Manejo de error si la fecha no es válida
      flash[:alert] = 'Fecha no válida'
      redirect_to root_path
    end
  end
  