Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root 'application#index'
  #get '/about' => 'about#index'
  #get '/preview' => 'about#preview'
  get '/preview', to: 'application#preview', as: :preview

  # # Document detail
  get '/document/:id/:slug', to: 'application#document', constraints: {id: /[-_a-zA-Z0-9]{16}/}, as: :document


  # # Basic search
  get '/search', to: 'application#search', as: :search
  resources :about
end
