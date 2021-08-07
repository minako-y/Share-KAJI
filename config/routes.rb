Rails.application.routes.draw do
  get 'messages/show'
  get 'monsters/new'
  get 'monsters/index'
  get 'monsters/show'
  get 'monsters/edit'
  get 'relationships/follower'
  get 'relationships/followed'
  get 'notifications/index'
  get 'tasks/new'
  get 'tasks/index'
  get 'tasks/show'
  get 'tasks/edit'
  devise_for :users
  root 'homes#top'
  get 'about' => 'homes#about', as: 'about'
end
