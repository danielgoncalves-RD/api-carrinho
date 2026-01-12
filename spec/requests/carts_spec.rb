# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/carts', type: :request do
  describe 'POST /add_item' do
    let(:cart) { Cart.create }
    let(:product) { Product.create(name: 'Test Product', price: 10.0) }
    let!(:cart_item) { CartItem.create(cart: cart, product: product, quantity: 1) }

    context 'when the product already is in the cart' do
      subject do
        post '/cart/add_item', params: { product_id: product.id, quantity: 1, teste: true }, as: :json
        post '/cart/add_item', params: { product_id: product.id, quantity: 1, teste: true }, as: :json
      end

      it 'updates the quantity of the existing item in the cart' do
        expect { subject }.to change { cart_item.reload.quantity }.by(2)
      end
    end
  end
end

RSpec.describe '/carts', type: :request do
  let(:product) do
    Product.create!(
      name: 'Produto Teste',
      price: 10.0
    )
  end

  describe 'POST /cart/add_item' do
    it 'adds a product to the cart and returns the cart' do
      post '/cart/add_item',
           params: { product_id: product.id, quantity: 2 },
           as: :json

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body['products'].length).to eq(1)
      expect(body['products'].first['quantity']).to eq(2)
      expect(body['total_price']).to eq(20.0)
    end
  end

  describe 'GET /cart' do
    it 'returns the current cart' do
      post '/cart/add_item',
           params: { product_id: product.id, quantity: 1 },
           as: :json

      get '/cart'

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body['products'].first['quantity']).to eq(1)
    end
  end
end
