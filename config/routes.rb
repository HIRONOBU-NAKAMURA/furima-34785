Rails.application.routes.draw do
  get 'items/index'
  devise_for :users
  get 'hello/index'
  root to: "items#index"
  resources :items
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
