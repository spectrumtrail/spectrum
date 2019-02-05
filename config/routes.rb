Rails.application.routes.draw do
  root to: "static_pages#home"

  match '/home' => "static_pages#home", via: [:get]
  match '/terms' => "static_pages#terms", via: [:get]
  match '/privacy' => "static_pages#privacy", via: [:get]
  match '/about' => "static_pages#about", via: [:get]

  resources :attachments, only: [:destroy]
  resources :locations, only: [:index, :show]
  resources :events, only: [:index, :show] do
    resources :registrations do
      resources :steps, controller: "registration_steps"
    end
    resources :races
  end
  resources :series, only: [:show]

  namespace :admin do
    get '/' => redirect('admin/dashboard')
    resource :dashboard, controller: 'dashboard'
    resources :events
    resources :locations
    resources :races
    resources :registrations
    resources :series
  end
end
