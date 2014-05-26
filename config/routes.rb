Rails.application.routes.draw do

  resources :tasks, only: [:index, :create, :update, :destroy]

  devise_for :users
  
  root 'tasks#index'

end
