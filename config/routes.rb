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
  end
  resources :signed_urls, only: :index
  resources :tracks, only: [:new, :create]
  resources :playlists, only: [:index]
  resources :playlistings, only: [:create]
  resources :comments, only: [:create]
  resources :notifications, only: [:index]

  mount ActionCable.server => '/cable'
end
