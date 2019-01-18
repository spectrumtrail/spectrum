Rails.application.routes.draw do
  root to: "static_pages#home"
  get "static_pages/home"
  get "static_pages/terms"
  get "static_pages/privacy"
  get "static_pages/about"

  resources :events, only: [:index, :show] do
    resources :races, only: [:index, :show] do
      resources :registrations, only: [:index, :new, :create]
    end
  end

  namespace :admin do
    get '/' => redirect('admin/dashboard')
    resource :dashboard, controller: 'dashboard'
    resources :locations
    resources :events
    resources :races
    resources :registrations
  end
end
