Rails.application.routes.draw do
  get 'places/new'
  get 'places/create'
  devise_for :users
  root to: "pages#home"
  get "about", to: "pages#about"
  resources :pets
  resources :cares
  resources :places
end
