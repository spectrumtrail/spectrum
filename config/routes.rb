require 'sidekiq/web'

Rails.application.routes.draw do
  root to: "static_pages#home"
  match '/about' => "static_pages#about", via: [:get]
  match '/coaching' => "static_pages#coaching", via: [:get]
  match '/danger' => "static_pages#danger", via: [:get]
  match '/home' => "static_pages#home", via: [:get]
  match '/store' => "static_pages#store", via: [:get]
  match '/terms' => "static_pages#terms", via: [:get]
  match '/privacy' => "static_pages#privacy", via: [:get]
  match 'policies' => "static_pages#policies", via: [:get]
  match '/no-script-warning' => 'static_pages#no_script_warning', via: [:get]
  match '/results' => 'static_pages#results', via: [:get]
  match '/events/vagabond-time-trials-2019', to: redirect("/events/vagabond-time-trials"), via: [:get]

  resources :attachments, only: [:destroy]
  resources :discount_codes do
    member do
      get :validate
    end
  end
  resources :events, only: [:index, :show] do
    resources :registrations, only: [:new, :create, :edit, :update] do
      resources :steps, controller: "registration_steps"
    end
    resources :races do
      resources :participants, only: [:index]
    end
  end
  resources :sponsors, only: [:index]
  resources :series, only: [:show]
  resources :team_members, path: "team", only: [:index, :show]

  put "newsletter_signup", to: "newsletter_signups#create"
  match "*path/newsletter_signup", to: "newsletter_signups#create", via: :put

  namespace :members do
    resource :profile, controller: "profile", only: [:show, :edit, :update]
  end

  devise_for :users, controllers: {
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    registrations: "users/registrations",
    sessions: "users/sessions",
    unlocks: "users/unlocks",
  }

  namespace :admin do
    authenticate :user, lambda { |u| u.is_admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
    get '/' => redirect('admin/dashboard')
    resource :dashboard, controller: 'dashboard'
    resources :attachments, only: [:index]
    resources :discount_codes
    resources :events
    resources :file_imports
    resources :locations
    resources :mailings
    resources :participants
    resources :payments
    resources :races do
      collection do
        get :archived
      end

      member do
        put :archive
      end
    end
    resources :refunds
    resources :registrations do
      collection do
        get :archived
      end
    end
    resources :series
    resources :sponsors
    resources :team_members
    resource :profile, controller: "profile", only: [:show, :edit, :update]
    resources :users
    resources :home_page_images
  end
end
