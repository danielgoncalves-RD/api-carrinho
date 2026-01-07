module Carts
  class RemoveProduct
    class ProductNotInCart < StandardError; end
    class CartNotFound < StandardError; end

    def self.call(session:, product_id:)
      new(session, product_id).call
    end

    def initialize(session, product_id)
      @session = session
      @product_id = product_id
    end

    def call
      ActiveRecord::Base.transaction do
        cart = find_cart!        
        cart.remove_product_by_id(@product_id)
        cart.touch_interaction!
        
        cart
      end
    end

    private

    def find_cart!
      raise CartNotFound unless @session[:cart_id]
      Cart.find(@session[:cart_id])
    end

  end
end