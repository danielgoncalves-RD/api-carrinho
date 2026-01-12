# frozen_string_literal: true

module Carts
  class AddProduct
    def self.call(cart:, product_id:, quantity:)
      new(cart, product_id, quantity).call
    end

    def initialize(cart, product_id, quantity)
      @cart = cart
      @product_id = product_id
      @quantity = quantity.to_i
    end

    def call
      product = Product.find(@product_id)
      @cart.add_product(product, @quantity)
      @cart.touch_interaction!
    end
  end
end
