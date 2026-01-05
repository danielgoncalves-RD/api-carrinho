module Carts
  class AddProduct
    def self.call(session:,product_id:, quantity:)
      new(session,product_id,quantity).call
    end

    def initialize(session, product_id,quantity)
      @session = session
      @product_id = product_id
      @quantity = quantity.to_i
    end

    def call
      ActiveRecord::Base.transaction do
        cart = find_or_create_cart
        product = Product.find(@product_id)

        cart.add_product(product,@quantity)

        cart
      end
    end

    private

    def find_or_create_cart
      return Cart.find(@session[:cart_id]) if @session[:cart_id]

      cart = Cart.create!
      @session[:cart_id] = cart.id
      cart
    end
  end
end