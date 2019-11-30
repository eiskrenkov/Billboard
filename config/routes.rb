Rails.application.routes.draw do
  resources :devices

  resources :settings, only: :index do
    put :update, on: :collection
  end

  root to: 'devices#index'
end
