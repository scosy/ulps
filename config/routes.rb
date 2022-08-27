Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :books
    resources :categories
    resources :episodes
    resources :filled_orders
    resources :user_episodes

    root to: "users#index"
  end
  resources :categories
  resources :episodes
  resources :books

  get "episodes/:id/get_episode", to: "episodes#get_episode", as: "get_episode"

  get 'public/index'
  get 'public/privacy'
  get 'public/conditions'

  get "user_episodes", to: "episodes#user_episodes"

  get "checkouts", to: "checkouts#index"

  get "checkout_membership", to: "checkouts#membership"
  get "checkout_extra_credit", to: "checkouts#extra_credit"
  get "checkout_pack_credits", to: "checkouts#pack_credits"
  
  get "checkout_membership_success", to: "checkouts#membership_success"
  get "checkout_extra_credit_success", to: "checkouts#extra_credit_success"
  get "checkout_pack_credits_success", to: "checkouts#pack_credits_success"

  get "billing", to: "billing#show"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  get 'users/my_account', to: "users#my_account", as: "my_account"
  
  root "public#index"

  # Ratings routes
  patch "rates", to: "ratings#create", as: "rates"
end
