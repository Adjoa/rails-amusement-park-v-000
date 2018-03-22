Rails.application.routes.draw do

  root 'users#welcome'

  resources :users, only: [:new, :create, :show, :destroy]
 
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

end