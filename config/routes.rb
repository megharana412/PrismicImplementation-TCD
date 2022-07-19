Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :application
  resources :about, only: :index
  #get '/about' => 'about#index'
end
