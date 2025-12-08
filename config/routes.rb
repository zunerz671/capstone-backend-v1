Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # admin-only index of all users
  get "/users", to: "users#index"

  post "/signup", to: "users#create"
  post "/login", to: "auth#login"

  resources :lessons do
    resources :lesson_pages, only: [ :create, :update, :destroy ]
  end

  resources :assessments do
    member do
      post :submit
    end
    resources :questions, only: [ :create, :update, :destroy, :show ]
  end
end
