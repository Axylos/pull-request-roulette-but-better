Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :sessions

  root to: "welcome#main"
  get "login", to: "sessions#login"
  get "register", to: "sessions#register"
  post "register", to: "users#create"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"
  resources :reviews
end
