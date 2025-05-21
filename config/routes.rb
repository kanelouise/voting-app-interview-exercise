Rails.application.routes.draw do
  post "/login",    to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  post "/register", to: "voters#create"
  post "/votes",    to: "votes#create"  


  # add votes and candidates routes as needed
end
