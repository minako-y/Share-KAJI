Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  root 'homes#top'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  patch 'level_up' => 'users#level_up', as: 'level_up'
  patch 'users/thanks' => 'users#thanks', as: 'thanks'
  get 'users/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  patch 'users/withdraw' => 'users#withdraw', as: 'withdraw_user'
  put 'users/withdraw' => 'users#withdraw'
  get '/mypage' => 'users#show', as: 'mypage'
  get '/mypage/edit' => 'users#edit', as: 'edit_user'
  patch '/mypage' => 'users#update'
  resources :rooms, only: [:new, :create]
  get 'tasks/search_task' => 'tasks#search_task', as: 'tasks_search'
  get 'tasks/search_template_task' => 'tasks#search_template_task', as: 'template_search'
  patch 'tasks/:id/change_progress' => 'tasks#change_progress', as: 'change_progress'
  resources :tasks do
    resources :messages, only: [:create, :show]
  end
  delete 'template_tasks' => 'template_tasks#destroy'
  delete 'notifications/destroy_all' => 'notifications#destroy_all', as: 'destroy_all_notifications'
  resources :notifications, only: [:index, :update]
  resources :monsters
end
