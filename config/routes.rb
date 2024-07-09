Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # USERS

  # Custom Users routes
  # resources :users, only: [:index, :show]

  # Nested resource for posts under users
  resources :users, only: [:index, :show, :edit, :update] do
    resources :posts, only: [:create, :destroy]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

end
