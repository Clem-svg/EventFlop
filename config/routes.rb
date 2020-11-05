Rails.application.routes.draw do

  root 'event#index'
  resources :events
  resources :users

  devise_for :users
end
