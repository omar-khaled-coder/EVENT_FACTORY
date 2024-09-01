Rails.application.routes.draw do
  resources :bookings do
    member do
      patch :accept
      patch :decline
      patch :cancel
    end
  end
  resources :spaces
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/user_profile", to: "pages#user_profile"
  get "/space_requests", to: "pages#space_requests"
  get 'policies', to: 'pages#policies'

    # Route for owner's dashboard
  get 'owner_dashboard', to: 'bookings#owner_dashboard', as: 'owner_dashboard'

# config/routes.rb
resources :spaces do
  get 'select_date', on: :member
end

  patch "/spaces/:id/approve", to: "pages#approve", as: :approve_space
  patch "/spaces/:id/reject", to: "pages#reject", as: :reject_space

  # Defines the root path route ("/")
  # root "posts#index"
end
