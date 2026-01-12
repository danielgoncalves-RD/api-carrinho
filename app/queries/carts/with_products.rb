# frozen_string_literal: true

module Carts
  class WithProducts
    def self.call(cart_id)
      Cart
        .where(id: cart_id)
        .includes(cart_products: :product)
        .first
    end
  end
end
