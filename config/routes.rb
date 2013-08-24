Ilostandfound::Application.routes.draw do

  root 'users#home'
  get 'home' => 'users#home', as: "home"
  resources :messages
  resources :users

  get "/session/new" => "sessions#new", as: "new_session"
  post "session" => "sessions#create", as: "sessions"
  delete "/session" => "sessions#destroy", as: "session"

  get "/delivery" => "users#delivery", as: "delivery"
  get "/test" => "users#test", as: "test"
end




