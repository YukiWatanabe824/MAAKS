Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  devise_scope :user do
    get '/users/:id/edit', to: 'users/registrations#edit'
    patch '/users/:id', to: 'users/registrations#update'
    delete '/users/:id/avatar', to: 'users/registrations#avatar_destroy'
  end

  resources :maps
  resources :spots
  resources :users, only: [:show, :index, :destroy] do
    resources :avatars, only: [:destroy]
  end
  resources :home
  resources :home_aside, only: [:index]




  root to: "home#index"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
