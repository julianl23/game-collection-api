# frozen_string_literal: true

Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  resources :game_collections, shallow: true do
    resources :game_collection_items, path: :items
  end
  resources :covers
  resources :multiplayer_modes
  resources :platforms
  resources :game_modes
  resources :companies
  resources :games
  resources :users, only: [:show]
  resource :user, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
