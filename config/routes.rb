# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts
  root 'posts#index'

  namespace :admin do
    root 'posts#index'
  end
end
