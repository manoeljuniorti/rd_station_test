require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  namespace :api, defaults: { format: :json }, path: '/api' do
    namespace :v1, path: '/v1' do
      resources :products
      get "up" => "rails/health#show", as: :rails_health_check

      root "rails/health#show"

      post   "/cart", to: "carts#create"
      get    "/cart", to: "carts#show"
      patch  "/cart/add_item", to: "carts#add_item"
      delete "/cart/:product_id", to: "carts#remove_item"
    end
  end
end
