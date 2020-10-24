Rails.application.routes.draw do
  root 'homes#top'
  get 'inquiries/new'
  post 'inquiries/confirm'
  post 'inquiries/thanks'

  devise_for :users
  patch 'users/withdraw' => 'users#withdraw', as: 'withdraw'
  resources :users, only: [:show, :index, :edit, :update] do
    resources :payments, only: [:create, :index]
  end

  get 'comics' => "pictures#comics", as: :comics
  get 'illustrations' => "pictures#illustrations", as: :illustrations
  get 'bookmarks' => "pictures#bookmarks", as: :bookmarks
  resources :pictures do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]
  end
  
  resources :genres, only: [:index, :create,:edit, :update]
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index]
  get 'search', to: "searches#search"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
