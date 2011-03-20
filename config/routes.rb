Jzcrm::Application.routes.draw do
  root :to => "users#show"

  get "javascripts/city_mapper"

  match 'reports/index' => 'reports#index', :as => :reports
  match 'dashboard' => 'users#show', :as => :dashboard
  match 'user/edit' => 'users#edit', :as => :edit_current_user
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login

  resources :tasks
  resources :activities
  resources :notes
  resources :sessions
  resources :users
  resources :addresses
  resources :cities
  resources :provinces
  resources :line_items
  resources :orders
  resources :contacts
  resources :products
end
