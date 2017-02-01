Rails.application.routes.draw do
  resources :categories
  resources :locations
  resources :follow_items
  resources :items do
    resources :item_images
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
end
