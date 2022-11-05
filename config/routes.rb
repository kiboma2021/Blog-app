# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users

  post 'authenticate', to: 'authentication#authenticate'
  post '/auth/signup', to:'authentication#signup'

  resources :users, only: [:index, :show] do 
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:create]
      resources :likes, only: [:create]
    end
  end

  root to: 'users#index'
end
