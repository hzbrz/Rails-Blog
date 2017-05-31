Rails.application.routes.draw do
  root 'welcome#home'

  get 'welcome/about', to: 'welcome#about'

  # Creates an articles table
  resources :articles

  get 'signup', to: 'users#new'

  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
