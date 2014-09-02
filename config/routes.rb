Rails.application.routes.draw do
  resources :apis do
    get 'login', on: :collection
    get 'join', on: :member
    get 'quit', on: :member
    get 'checkin', on: :member
    get 'mapping', on: :member
    get 'sign_in', on: :collection
    get 'sign_up', on: :collection
    get 'new_trip', on: :member
    get 'add_part', on: :member
  end

  resources :participants

  resources :trips

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
