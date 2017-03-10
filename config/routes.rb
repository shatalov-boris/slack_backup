require "sidekiq/web"

Rails.application.routes.draw do
  default_url_options host: ENV.fetch("DOMAIN") { "localhost:3000" }
  root "channels#index"

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resource :team, only: [:show] do
    get ":slug", to: "teams#user", as: :member
  end

  resources :channels, only: [:index, :show]

  authenticate :user, ->(u) { u.email == ENV["ADMIN_EMAIL"] } do
    mount Sidekiq::Web => "/sidekiq"
  end
end
