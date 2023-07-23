Rails.application.routes.draw do
  resources :maps
  resources :spots
  resources :users
  resources :home
  root to: "home#index"
end
