Rails.application.routes.draw do
  # get 'static_pages/home'
  # get 'static_pages/about'
  # get 'static_pages/help'
  # get 'static_pages/contact'

  match '/help', to: 'static_pages#help', via: [:get]
  match '/about', to: 'static_pages#about', via: [:get]
  match '/contact', to: 'static_pages#contact', via: [:get]

  resources :categories
  resources :locations
  resources :items do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
