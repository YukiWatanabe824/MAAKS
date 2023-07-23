Rails.application.routes.draw do
  devise_for :users
  resources :maps
  resources :spots
  resources :users
  resources :home
  root to: "home#index"
end
