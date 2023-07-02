Rails.application.routes.draw do
  resources :maps
  resources :spots
  resources :users
  root to: "home#index"
end
