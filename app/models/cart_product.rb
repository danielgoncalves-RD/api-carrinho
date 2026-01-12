# frozen_string_literal: true

class CartProduct
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quantity, type: Integer, default: 0

  belongs_to :cart
  belongs_to :product

  def total_price
    quantity * product.price
  end
end
