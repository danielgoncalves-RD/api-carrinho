FactoryBot.define do
  factory :shopping_cart, class: 'Cart' do
    abandoned_at { nil }  
  end
end