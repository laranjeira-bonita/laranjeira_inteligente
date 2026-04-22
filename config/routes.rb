Rails.application.routes.draw do
  root "products#index"
  resources :promotions, only: [:index, :show]
  resources :users, only: [:update]
  resources :purchases, only: [:index] do
    collection do
      post :confirm_payment
    end
  end
  resources :products, only: [:index] do
    member do
      delete :purge_image
      post :buy
    end
  end 
  resources :participations, only: [:index, :update]
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/promotions/:promotion_id/quantity", to: "products#select_quantity", as: :select_quantity
end
