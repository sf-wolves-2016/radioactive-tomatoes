Rails.application.routes.draw do
  resources :reviews, except: [:new, :index]

  resources :movies, only: [:index, :show]

  resources :genres, only: [:show]

  resources :actors, only: [:show]

  root 'movies#index'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

end
