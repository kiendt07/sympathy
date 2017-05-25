Rails.application.routes.draw do
  get "users/new"

  root "pages#index"

  devise_for :users,
    class_name: "FormUser", controllers: {
      omniauth_callbacks: "omniauth_callbacks", registrations: "registrations"}

  resources :users, only: [:show] do
    resources :tracks, only: [:show]
  end
  resources :tracks, except: [:show]

  resources :posts, only: [:show, :destroy]

  resources :signed_urls, only: :index

  get "/home", to: "pages#show", as: "home"
  get "/", to: "pages#index", as: "landing"
  resources :users, only: [:index, :show] do
  	resources :relationships, only: [:index]
  end
  resources :relationships, only: [:create, :destroy]
end
