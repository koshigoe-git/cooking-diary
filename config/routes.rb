Rails.application.routes.draw do
  #root to: トップページ指定
  root to: 'toppages#index'

  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  resources :users, only:[:index, :show, :new, :create]
 end