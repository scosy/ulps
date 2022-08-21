Rails.application.routes.draw do
  resources :categories
  resources :episodes
  resources :books
  get 'public/index'
  get 'public/privacy'
  get 'public/conditions'

  get "user_episodes", to: "episodes#user_episodes"

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
  
  root "public#index"
end
