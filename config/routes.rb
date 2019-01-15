Rails.application.routes.draw do
  root to: "static_pages#home"
  get "static_pages/home"
  get "static_pages/terms"
  get "static_pages/privacy"
  get "static_pages/about"

  namespace :admin do
    get '/' => redirect('admin/dashboard')
    resource :dashboard, controller: 'dashboard' do
    end
    resources :locations
    resources :events do
      resources :races do
        resources :registrations
      end
    end
  end
end
