Ilostandfound::Application.routes.draw do

  root 'users#home'
  get 'home' => 'users#home', as: "home"
  get "/delivery" => "auth#delivery", as: "auth_delivery"
  resources :messages
  resources :users

  get "/session/new" => "sessions#new", as: "new_session"
  post "session" => "sessions#create", as: "sessions"
  delete "/session" => "sessions#destroy", as: "session"

end




