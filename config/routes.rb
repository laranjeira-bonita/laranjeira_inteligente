Rails.application.routes.draw do
  root "products#index"
  resources :activities
  resources :descriptions
  resources :tickers
  resources :promotions
  resources :purchases
  resources :products do
    member do
      delete :purge_image
    end
  end  
  resources :stores
  devise_for :users, controllers: { sessions: 'users/sessions' }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

end
