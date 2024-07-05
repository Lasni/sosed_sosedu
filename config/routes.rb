Rails.application.routes.draw do
  root "home#index"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # AUTH
  # register
  resource :registration
  # login
  resource :session
  # password reset
  resource :password_reset
  # password update while logged in
  resource :password

  # USERS
  # resourceful routing
  resources :users do
    # POSTS
    resources :posts
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
