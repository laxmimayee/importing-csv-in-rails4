Rails.application.routes.draw do
  get 'users/index'
  resources :user_imports
  root 'users#index'
  resources :users do
  collection { post :import }
  end

end
