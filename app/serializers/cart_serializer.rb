# frozen_string_literal: true

class CartSerializer
  def initialize(cart)
    @cart = cart
  end

  def as_json
    {
      id: @cart.id,
      products: products_as_json,
      total_price: @cart.total_price,
      updated_at: @cart.updated_at,
      abandoned_at: @cart.abandoned_at
    }
  end

  def products_as_json
    @cart.cart_products.map do |item|
      {
        id: item.product.id,
        name: item.product.name,
        quantity: item.quantity,
        unit_price: item.product.price,
        total_price: item.total_price
      }
    end
  end
end
