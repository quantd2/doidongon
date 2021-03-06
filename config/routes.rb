Rails.application.routes.draw do

  match '/help', to: 'static_pages#help', via: [:get]
  match '/about', to: 'static_pages#about', via: [:get]
  match '/contact', to: 'static_pages#contact', via: [:get]
  match '/home' , to: 'static_pages#home', via: [:get]

  resources :users, only: [:index, :show]
  devise_scope :user do
    resources :users#, only: [:edit], to: 'devise/registrations#edit'
    #get 'users/edit', to: 'devise/registrations#edit'
  end

  resources :categories
  resources :locations

  # resources :items
  resources :items do
    resources :relationships, only: [:new, :create, :destroy]
  end

  get "followed", to: 'items#followed_items'
  get "follower", to: 'items#follower_items'

  devise_for :users, path_prefix: 'd'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get 'dashboard/index'

end
