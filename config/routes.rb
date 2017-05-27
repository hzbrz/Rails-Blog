Rails.application.routes.draw do
  root 'welcome#home'

  get 'welcome/about', to: 'welcome#about'

  # Creates an articles table 
  resources :articles
end
