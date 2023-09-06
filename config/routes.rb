Rails.application.routes.draw do
  require "sidekiq/web"
  mount Sidekiq::Web => "/workers"

  resources :jobs
  resources :reqs
  get "req", to: "reqs#create"
  get "headers", to: "reqs#headers"
  get "debug", to: "reqs#debug"

  root to: redirect("reqs/new")
end
