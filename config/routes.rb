# frozen_string_literal: true

Rails.application.routes.draw do
  resources :game_collections
  resources :covers
  resources :multiplayer_modes
  resources :users
  resources :platforms
  resources :game_modes
  resources :companies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
