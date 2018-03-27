Rails.application.routes.draw do
  root to: redirect('/users')

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index] do
    resources :interviews
  end
end
