# frozen_string_literal: true

class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :price, type: Float

  has_many :cart_products
  validates_presence_of :name, :price
  validates_numericality_of :price, greater_than_or_equal_to: 0
end
