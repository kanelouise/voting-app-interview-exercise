Rails.application.routes.draw do
  root "home#index"
  
  #controllers
  namespace :api do
    post "/login",    to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    post "/register", to: "voters#create"
    post "/votes",    to: "votes#create"
    get "/results", to: "results#index"
    get "/candidates", to: "candidates#index"
  end

  #react routes
  get '*path', to: 'home#index', constraints: ->(req) { !req.xhr? && req.format.html? }
end
