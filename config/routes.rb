Rails.application.routes.draw do
  resources :categories
  resources :episodes
  resources :books
  get 'public/index'
  get 'public/privacy'
  get 'public/conditions'

  get "user_episodes", to: "episodes#user_episodes"

  get "checkout", to: "checkouts#show"
  get "checkout/success", to: "checkouts#success"
  get "checkout/cancel", to: "checkouts#cancel"

  get "billing", to: "billing#show"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  root "public#index"
end
