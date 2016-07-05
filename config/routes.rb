Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations' }
  resources :payments
  root 'payments#index'
  resources :stats, only: :index
  resources :settings, only: :index do
    collection do
      post :set_default_category
      post :import_csv
      get :export_csv
    end
  end
  resources :categories
end
