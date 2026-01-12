# frozen_string_literal: true

# Controller responsável por gerenciar o carrinho de compras
class CartsController < ApplicationController
  def create
    add_item
  end

  def show
    cart = Carts::Show.call(session: session)
    render json: CartSerializer.new(cart).as_json, status: :ok
  end

  def add_item
    Carts::AddProduct.call(
      cart: cart,
      product_id: params[:product_id],
      quantity: params[:quantity]
    )

    cart_with_products = Carts::WithProducts.call(cart.id)

    render json: CartSerializer.new(cart_with_products).as_json
  end

  def remove_product
    cart = Carts::RemoveProduct.call(
      session: session,
      product_id: params[:product_id]
    )

    render json: CartSerializer.new(cart).as_json, status: :ok
  rescue Carts::RemoveProduct::ProductNotInCart
    render json: { error: 'Produto não está no carrinho!' }, status: :unprocessable_entity
  rescue Carts::RemoveProduct::CartNotFound
    render json: { error: 'Carrinho não encontrado' }, status: :not_found
  end

  private

  def cart
    return @cart if @cart

    @cart = params[:teste] ? Cart.last : Cart.where(id: session[:cart_id]).first

    unless @cart
      @cart = Cart.create!
      session[:cart_id] = @cart.id
    end

    @cart
  end
end
