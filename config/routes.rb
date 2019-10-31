Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :admin do
    resources :users
  end

  # タスク登録機能
  root to: 'blogs#index'
  resources :blogs do
    post :confirm, action: :confirm_new, on: :new
  end

  # お気に入り登録機能
  resources :favorites

  # お気に入り欄から削除するときに、確認画面を挟むように実装。

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
