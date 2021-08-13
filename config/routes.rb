Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  root 'homes#top'
  get 'about' => 'homes#about', as: 'about'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  patch 'level_up' => 'users#level_up', as: 'level_up'
  patch 'users/thanks' => 'users#thanks', as: 'thanks'
  get 'users/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  patch 'users/withdraw' => 'users#withdraw', as: 'withdraw_user'
  put 'users/withdraw' => 'users#withdraw'
  resources :users, only: [:show, :edit, :update] do
    get 'follower' => 'relationships#follower', as: 'follower'
    get 'followed' => 'relationships#followed', as: 'followed'
    resources :relationships, only: [:create, :destroy]
  end
  get 'rooms/search' => 'rooms#search', as: 'room_search'
  resources :rooms
  resources :tasks do
    resources :messages, only: [:create, :show]
  end
  resources :notifications, only: [:index]
  resources :monsters
end
