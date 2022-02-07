Rails.application.routes.draw do
  resources :projects
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/auth/basecamp", to: "oauth#basecamp"
  get "/auth/basecamp/callback", to: "oauth#basecamp_callback"
  get "/auth/basecamp/check", to: "oauth#basecamp_check"

  match "/rtm", to: "slack_rtm#receive", via: [:get, :post]

  post "/webhooks/basecamp", to: "basecamp_webhooks#event"
end
