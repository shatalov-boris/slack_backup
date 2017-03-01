Rails.application.routes.draw do
  root "home#index"

  get "slack_oauth", to: "oauth#slack_oauth"
  get "slack_oauth/callback", to: "oauth#slack_oauth_callback"
end
