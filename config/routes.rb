Rails.application.routes.draw do
  get 'contacts/contact'
  get 'rooms/show'
  get 'picture_contents/show'
  get 'picture_contents/edit'
  get 'users/show'
  get 'users/edit'
  devise_for :users
  get 'homes/top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
