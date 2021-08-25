Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  root 'homes#top'
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
  resources :rooms, only: [:new, :create]
  get 'tasks/search_task' => 'tasks#search_task', as: 'tasks_search'
  get 'tasks/search_template_task' => 'tasks#search_template_task', as: 'template_search'
  resources :tasks do
    resources :messages, only: [:create, :show]
  end
  resources :notifications, only: [:index]
  resources :monsters
end
