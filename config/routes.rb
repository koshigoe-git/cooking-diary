Rails.application.routes.draw do

  get 'favorites/create'
  get 'favorites/destroy'
  #root to: トップページ指定
  root to: 'toppages#index'
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  get "signup", to: "users#new"
  resources :users, only:[:index, :show, :new, :create ,:edit, :update, :destroy] do
    member do
      get :likes
      get :admin
    end
  end
  
  resources :posts, only:[:show, :new, :create, :edit, :update, :destroy]
  resources :favorites, only:[:create, :destroy]
 
 end