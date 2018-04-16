# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :posts
  root 'posts#index'

  resources :users do
    collection do
      get :feeds
      get :ranking
    end

    member do
      get :post
      get :comment
      get :collect
      get :draft
      get :friend
    end
  end

  namespace :admin do
    resources :users, only: %i[index edit update]
    resources :categories
    root 'users#index'
  end
end
