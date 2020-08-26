Rails.application.routes.draw do

  get 'archived_events/index'
  root 'events#index'

  resources :members, only: [:show, :edit, :update, :index]
  #resources :users, only: [:show]
  
  resources :events, only: [:new, :create, :show, :edit, :destroy]

  resources :promotions, only: [:index]

  resources :archived_event, only: [:index]

  resources :events do
    resources :attendances, only: [:new, :index, :create]
    resources :charges
    resources :promotions, only: [:destroy, :edit]
  end

  resources :web_master, only: [:index, :create]


  #strip routes

  devise_for :users
  # For details on tresources :chargeshe DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #PAS DE GET NI DE POST SVP. QUE DES resources...

    #STATIC

end