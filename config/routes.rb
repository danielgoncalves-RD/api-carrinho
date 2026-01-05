require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :products
  get "up" => "rails/health#show", as: :rails_health_check

  root "rails/health#show"
  resource :cart, only: [:show,:create] do
        post :add_product
        delete ':product_id', action: :remove_product
  end
end
