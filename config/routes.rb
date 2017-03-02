Rails.application.routes.draw do
  default_url_options host: ENV.fetch("DOMAIN") { "localhost:3000" }
  root "teams#show"

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resource :team, only: [:show]
end
