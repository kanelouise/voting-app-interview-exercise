Rails.application.routes.draw do
  get 'results/index'
  root "home#index"
  
  post "/login",    to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  post "/register", to: "voters#create"
  post "/votes",    to: "votes#create"
  get "/candidates", to: "candidates#index"
  get "/results", to: "results#index"

  #react routes
  get '*path', to: 'home#index', constraints: ->(req) { !req.xhr? && req.format.html? }
end
