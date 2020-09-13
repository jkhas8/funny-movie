Rails.application.routes.draw do
  root "videos#index"
  resources :sessions, only: [:create, :destroy]
  resources :videos, only: [:index, :new, :create]
  get "logout", to: "sessions#destroy", as: "logout"
end
