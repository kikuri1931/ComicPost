Rails.application.routes.draw do
  root 'homes#top'
  get 'contact' => "homes#contact", as: :contact

  devise_for :users
  resources :users, only: [:show, :edit, :update]
  patch 'users/withdraw' => 'users#withdraw', as: 'withdraw'
  get 'comics' => "pictures#comics",as: :comics
  get 'illustrations' => "pictures#illustrations",as: :illustrations
  get 'bookmarks' => "pictures#bookmarks",as: :bookmarks
  resources :pictures do
  	resource :favorites, only: [:create,:destroy]
  	resources :comments, only: [:create, :destroy]
  	resource :bookmarks, only:[:create, :destroy]
  end
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
  get '/search', to: "search#search"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
