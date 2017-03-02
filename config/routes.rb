Rails.application.routes.draw do
  default_url_options host: ENV.fetch("DOMAIN") { "localhost:3000" }
  root "home#index"

  devise_for :users

  get "slack_oauth", to: "oauth#slack_oauth"
  get "slack_oauth/callback", to: "oauth#slack_oauth_callback"
end
