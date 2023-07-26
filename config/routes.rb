Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  devise_scope :user do
    get '/users/:id/edit', to: 'users/registrations#edit'
    patch '/users/:id', to: 'users/registrations#update'
  end
  resources :maps
  resources :spots
  resources :users
  resources :home
  root to: "home#index"

end
