class Cart < ApplicationRecord
  validates_numericality_of :total_price, greater_than_or_equal_to: 0
  has_many :cart_products, dependent: :destroy
  has_many :products, through: :cart_products

  scope :active, -> { where(abandoned_at: nil) }
  scope :inactive_for_3_hours, -> {
    where(abandoned_at: nil)
    .where("last_interaction_at < ?", 3.hours.ago)
  }  
  scope :abandoned_for_7_days, -> {
    where("abandoned_at < ?", 7.days.ago)
  }

  def abandoned?
    abandoned_at.present?
  end

  def mark_as_abandoned
        update!(abandoned_at: Time.current)
  end

  def total_price
    cart_products.sum(&:total_price)
  end

  def add_product(product, quantity)
    quantity = quantity.to_i
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

  def remove_if_abandoned
    return unless abandoned?
    return unless last_interaction_at <= 7.days.ago

    destroy!
  end

  def touch_interaction!
    update!(last_interaction_at: Time.current)
  end

end
