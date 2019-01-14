Rails.application.routes.draw do
  root to: "static_pages#home"
  get "static_pages/home"
  get "static_pages/terms"
  get "static_pages/privacy"

  namespace :admin do
    resources :locations
  end
end
