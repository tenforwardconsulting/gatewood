Rails.application.routes.draw do
  devise_for :users
  resources :teams
  resources :projects
  resources :users, only: :create



  get "/dashboard", to: "home#dashboard"
  get "/auth/basecamp", to: "basecamp#oauth_redirect", as: "auth_basecamp"
  get "/auth/basecamp/callback", to: "basecamp#oauth_callback"
  get "/auth/basecamp/check", to: "basecamp#oauth_check"

  get "/auth/slack", to: "slack#oauth_redirect", as: "auth_slack"
  get "/auth/slack/callback", to: "slack#oauth_callback"
  get "/auth/slack/check", to: "slack#oauth_check"



  post "/rtm", to: "slack_rtm#receive"
  get "/rtm/config", to: "slack_rtm#team_configs"

  post "/webhooks/basecamp", to: "basecamp#webhook"

  root "home#home"
end
