Rails.application.routes.draw do
  get "users/new"

  root "pages#index"

  devise_for :users,
    class_name: "FormUser",
    controllers: {
      omniauth_callbacks: "omniauth_callbacks",
      registrations: "registrations"
    }

  get "/home", to: "pages#show", as: "home"
  get "/", to: "pages#index", as: "landing"
  get "/explore", to: "explore#index", as: "explore"
  resources :users, only: [:index, :show] do
  	resources :relationships, only: [:index]
  end
  resources :relationships, only: [:create, :destroy]
  resources :posts, only: [:show, :destroy] do
    resources :likes, only: [:create, :destroy]
    resources :shareds, only: [:create]
    resources :playlists, only: [:create]
    resources :impressions, only: [:create]
  end
  resources :signed_urls, only: :index
  resources :tracks, only: [:new, :create, :show]
  resources :playlists, only: [:index, :show]
  resources :playlistings, only: [:create]
  resources :comments, only: [:create]
end
