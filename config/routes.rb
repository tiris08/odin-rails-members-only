Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'posts#index'
  resources :posts do
    get :like, on: :member
  end
end
