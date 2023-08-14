Rails.application.routes.draw do


  resources :user_stocks, only: [:create, :destroy]
  devise_for :users
  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friend', to: 'users#search'
  resources :friendship, only: [:create, :destroy]
  resources :users, only: [:show], :constraints => { :id => /[0-9|]+/ }
  post 'friendship/:id' => 'friendship#create', as: :create_friendship


 get 'search_friends', to: 'users#search_friend', as: 'search_friends'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
