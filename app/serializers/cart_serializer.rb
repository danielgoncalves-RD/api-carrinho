class CartSerializer
  def initialize(cart)
    @cart = cart
  end

  def as_json
    {
      id: @cart.id,
      products: @cart.cart_products.map do |item|
        {
          id: item.product.id,
          name: item.product.name,
          quantity: item.quantity,
          unit_price: item.product.price,
          total_price: item.total_price
        }
      end,
      total_price: @cart.total_price
    }
  end
end