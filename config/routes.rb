# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :categories, only: :show
  resources :posts do
    resources :comments, only: %i[create edit update destroy]
    collection do
      get :feeds
    end
    member do
      post :collect
      post :uncollect
    end
  end
  resources :comments
  root 'posts#index'
  resources :users do
    resources :comments, only: %i[edit update destroy]
    member do
      get :post
      get :comment
      get :collect
      get :draft
      get :friend
    end
  end
  resources :friendships, only: %i[create destroy] do
    member do
      post :accept
    end
  end

  namespace :admin do
    resources :users, only: %i[index edit update]
    resources :categories
    root 'users#index'
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post "/login" => "auth#login"
      post "/logout" => "auth#logout"
      resources :articles, only: %i[index create show update destroy]
    end
  end
end
