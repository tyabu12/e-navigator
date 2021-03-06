Rails.application.routes.draw do
  root to: 'users#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index] do
    resources :interviews
  end

  # user_id は必要なし
  namespace :interviews do
    post :apply
  end

end
