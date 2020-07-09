Rails.application.routes.draw do
  get 'toppages/index'
  #root to: トップページ指定
  root to: 'toppages#index'

  #get "signup", to: "users#new"
  #get "login", to: "sessions#new"
  #resources :users, only:[:index, :show, :new, :create]
 end