Rails.application.routes.draw do


  get 'tasks/new'
  root 'pages#index'
  get 'sessions/new'
  put 'tasks/start'
  put 'tasks/finish'
  resources :users
  resources :tasks, :only => [:index, :show, :new, :create, :update, :destroy, :edit]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
