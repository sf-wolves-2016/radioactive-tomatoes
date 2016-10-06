Rails.application.routes.draw do
  resources :reviews, except: [:new, :index]

  resources :movies, only: [:index, :show]

  root 'movies#index'
end
