Rails.application.routes.draw do
  resources :locations
  root to: "static_pages#home"

  get "static_pages/home"
  get "static_pages/terms"
  get "static_pages/privacy"
end
