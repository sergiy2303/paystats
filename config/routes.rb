Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations' }
  resources :payments
  root 'payments#index'
  resources :stats, only: :index
  resources :settings, only: :index
  resources :categories
end
