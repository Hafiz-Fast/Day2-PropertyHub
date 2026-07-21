Rails.application.routes.draw do
  root "properties#index"

  resources :properties do
    # member route applies to a single record
    member do
      post: favourite
    end

    collection do
      get: search
    end
  end

  # Custom Routes: Use when they do not much the 7 actions under the resources
  get "properties/search", to: "properties#search"

  resources :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
