Ilostandfound::Application.routes.draw do

  root 'users#home'
  get 'home' => 'users#home', as: "home"
  get 'find' => 'users#find', as: "find"
  resources :messages
  resources :users
  resource  :verifications
  resources :points

  post "users/:id/print" => "users#print", as: "print"

  get "/session/new" => "sessions#new", as: "new_session"
  post "session" => "sessions#create", as: "sessions"
  delete "/session" => "sessions#destroy", as: "session"

  get "/delivery" => "users#delivery", as: "delivery"
  get "/test" => "users#test", as: "test"

end




