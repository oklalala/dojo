# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :categories, only: :show
  resources :posts do
    resources :comments, only: %i[create edit update destroy]
    collection do
      get :feeds
      get :ranking
    end
  end
  root 'posts#index'
  resources :users do
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
