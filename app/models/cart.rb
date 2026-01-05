class Cart < ApplicationRecord
  validates_numericality_of :total_price, greater_than_or_equal_to: 0
  has_many :cart_products, dependent: :destroy
  has_many :products, through: :cart_products

  def total_price
    cart_products.sum(&:total_price)
  end

  def add_product(product, quantity)
    item = cart_products.find_or_initialize_by(product: product)
    item.quantity ||= 0
    item.quantity += quantity
    item.save!
  end

  def remove_product_by_id(product_id)
    item = cart_products.find_by(product_id: product_id)
    raise Carts::RemoveProduct::ProductNotInCart unless item
    item.destroy!
  end
  # TODO: lógica para marcar o carrinho como abandonado e remover se abandonado

end
