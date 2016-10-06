Rails.application.routes.draw do
  get 'movies/index'

  get 'movies/show'

  resources :movies, only: [:index, :show]

  root 'movies#index'
end
