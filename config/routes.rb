Rails.application.routes.draw do
  root "sessions#new"
  resources :sessions, only: [:new, :create, :destroy]
  get "logout", to: "sessions#destroy", as: "logout"
end
