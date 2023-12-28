Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users, skip: [ :registrations, :sessions, :password ], controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  devise_scope :user do
    get '/users/:id/edit', to: 'users/registrations#edit'
    patch '/users/:id', to: 'users/registrations#update'
    delete '/users/sign_out', to: 'users/sessions#destroy'
    get '/users/sign_up', to: 'devise/registrations#new'
  end

  resources :spots
  resources :users, only: [:show, :destroy] do
    resources :avatars, only: [:destroy]
  end

  resources :home, only: [:index]
  resources :home_aside, only: [:index]

  root to: "home#index"

  namespace :admins do
    resources :spots, only: [:update, :destroy]
    resources :users, only: [:index, :edit, :update, :destroy] do
      resources :avatars, only: [:destroy]
    end
  end

end
