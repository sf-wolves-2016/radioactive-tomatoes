Rails.application.routes.draw do
  get 'users/create'

  get 'movies/index'

  get 'movies/show'

  resources :movies, only: [:index, :show]

  root 'movies#index'


  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

end
