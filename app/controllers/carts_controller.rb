class CartsController < ApplicationController
  def create
    add_product
  end  
  
  def show
        cart = Carts::Show.call(session: session)
        render json: CartSerializer.new(cart).as_json, status: :ok
  end

  def add_product
    cart = Carts::AddProduct.call(
      session: session,
      product_id: params[:product_id],
      quantity: params[:quantity]
    )

    render json: CartSerializer.new(cart).as_json, status: :ok
  end
 
  def remove_product
    cart = Carts::RemoveProduct.call(
      session: session,
      product_id: params[:product_id]
    )

    render json: CartSerializer.new(cart).as_json, status: :ok
  rescue Carts::RemoveProduct::ProductNotInCart
    render json: { error: 'Produto não está no carrinho!'}, status: :unprocessable_entity
  rescue Carts::RemoveProduct::CartNotFound
    render json: { error: 'Carrinho não encontrado'}, status: :not_found   
  end
  
end
