Rails.application.routes.draw do
  root to: "static_pages#home"
  get "static_pages/home"
  get "static_pages/terms"
  get "static_pages/privacy"
  get "static_pages/about"

  resources :attachments, only: [:destroy]
  resources :locations, only: [:index, :show]
  resources :events, only: [:index, :show] do
    resources :races
    resources :registrations do
      resources :participants
      resources :payments
    end
  end

  namespace :admin do
    get '/' => redirect('admin/dashboard')
    resource :dashboard, controller: 'dashboard'
    resources :locations
    resources :events
    resources :races
    end
end
