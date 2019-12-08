Rails.application.routes.draw do
  root 'pages#index'
  resources :users
  resources :tasks do
    collection do
      put :start
      put :finish
    end
  end
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
