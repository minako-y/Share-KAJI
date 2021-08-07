Rails.application.routes.draw do

  get 'users/show'
  get 'users/edit'
  devise_for :users

  root 'homes#top'
  get 'about' => 'homes#about', as: 'about'
  resources :users, only: [:show, :edit, :update] do
    patch 'level_up' => 'users#level_up', as: 'level_up'
    resources :relationships, only: [:create, :destroy]
    get 'follower' => 'relationships#follower', as: 'follower'
    get 'followed' => 'relationships#followed', as: 'followed'
  end
  resources :tasks do
    resources :messages, only: [:create, :show]
  end
  resources :notifications, only: [:index]
  patch 'users/thanks' => 'users#thanks', as: 'thanks'
  resources :monsters
end
