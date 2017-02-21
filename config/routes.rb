Rails.application.routes.draw do
  # get 'users/index'
  #match '/users',   to: 'users#index', via: 'get'

  match '/help', to: 'static_pages#help', via: [:get]
  match '/about', to: 'static_pages#about', via: [:get]
  match '/contact', to: 'static_pages#contact', via: [:get]

  # resources :users, except: [:edit]
  devise_scope :user do
    resources :users#, only: [:edit], to: 'devise/registrations#edit'
    #get 'users/edit', to: 'devise/registrations#edit'
  end

  resources :categories
  resources :locations

  # resources :items
  resources :items do
    member do
      get :following, :followers
    end
    resources :relationships, only: [:new, :create, :destroy]
  end

  devise_for :users, path_prefix: 'd',
    :controllers => {sessions: 'sessions', registrations: 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get 'dashboard/index'

end
