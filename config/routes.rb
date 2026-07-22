Rails.application.routes.draw do
  root "properties#index"

  resources :users

  resources :properties do
    # member route applies to a single record
    member do
      post :favorite
    end

    collection do
      get :search
    end
  end

  # Custom Routes: Use when they do not much the 7 actions under the resources
  # get "properties/search", to: "properties#search"
end
