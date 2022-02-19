Rails.application.routes.draw do
  devise_for :users
  resources :teams
  resources :projects
  resources :users, only: :create



  get "/dashboard", to: "home#dashboard"
  get "/auth/basecamp", to: "oauth#basecamp", as: "auth_basecamp"
  get "/auth/basecamp/callback", to: "oauth#basecamp_callback"
  get "/auth/basecamp/check", to: "oauth#basecamp_check"

  match "/rtm", to: "slack_rtm#receive", via: [:get, :post]

  post "/webhooks/basecamp", to: "basecamp_webhooks#event"

  root "home#home"
end
