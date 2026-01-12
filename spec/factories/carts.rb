# frozen_string_literal: true

FactoryBot.define do
  factory :shopping_cart, class: 'Cart' do
    abandoned_at { nil }
  end
end
