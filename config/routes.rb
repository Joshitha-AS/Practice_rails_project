Rails.application.routes.draw do
  
  get "up" => "rails/health#show", as: :rails_health_check

  require 'sidekiq/web'

  mount Sidekiq::Web => '/sidekiq'
  
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'signup', to: 'users/registrations#register'
      post 'login', to: 'users/sessions#login'
      resources :users, only: [:index, :show]
      resources :products, only: [:index,:create, :show, :update, :destroy]

      resource :cart, only: [:show, :create, :update, :destroy] do
        resources :cart_items, only: [:index, :create, :update, :destroy]
      end
      resources :orders, only: [:index, :create, :show] do
        resources :order_items, only: [:index, :show]
      end
    end
  end
end
