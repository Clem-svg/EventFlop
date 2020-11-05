Rails.application.routes.draw do

  root 'events#index'
  resources :events
  resources :users

  devise_for :users
end
