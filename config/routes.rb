Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  # Direct routes for posts
  resources :posts, only: [:index, :show]

  # Nested resource for posts under users
  resources :users do
    resources :posts do
      resources :messages, only: [:create]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
