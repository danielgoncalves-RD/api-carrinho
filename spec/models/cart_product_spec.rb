require 'rails_helper'

RSpec.describe CartProduct, type: :model do
  let(:product) { Product.create!(name: "Produto", price: 10.0) }
  let(:cart) { Cart.create! }

  subject do
    described_class.create!(
      cart: cart,
      product: product,
      quantity: 2
    )
  end

  describe '#total_price' do
    it 'returns quantity * product price' do
      expect(subject.total_price).to eq(20.0)
    end
  end
end
