Rails.application.routes.draw do
  resources :devices do
    post :synchronize, on: :member
  end

  resources :settings, only: :index do
    put :update, on: :collection
  end

  root to: 'devices#index'
end
