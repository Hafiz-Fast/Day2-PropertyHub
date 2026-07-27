Rails.application.routes.draw do
  devise_for :users
  root "properties#index"

  # Account creation, login, password updates, and account deletion are
  # handled by Devise. Community profiles remain read-only here.
  resources :users, only: %i[index show]

  resources :properties do
    # member route applies to a single record
    member do
      post :favorite
    end

    collection do
      get :search
      get :favorites
    end
    resources :reviews, only: [:create, :destroy]
  end

  # Custom Routes: Use when they do not much the 7 actions under the resources
  # get "properties/search", to: "properties#search"
end
