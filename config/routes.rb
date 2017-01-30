Rails.application.routes.draw do

  mount Attachinary::Engine => "/attachinary"

  devise_for :users, controllers: { registrations: 'registrations' }

  root to: 'pages#home'

  post '/subscribe', to: 'pages#subscribe'

  # Routes for core user side
  resources :users, only: [ :show, :edit, :update ] do

    # User Pages
    get 'profile', to: 'users#profile'
    get 'digital', to: 'users#digital'
    get 'proof', to: 'users#proof'
    get 'notes', to: 'users#notes'
    resources :proofs

    # Assignee Pages
    resources :assignees do
      get 'notes', to: 'assignees#notes'
      resources :notes, only: [:new, :create, :edit, :update, :destroy]
    end

    # Guardian Pages
    resources :guardians, controller: 'assignees', type: 'Guardian' do
      get 'notes', to: 'assignees#notes'
      resources :notes, only: [:new, :create, :edit, :update, :destroy]
    end

    # Recipient Pages
    resources :recipients, controller: 'assignees', type: 'Recipient' do
      get 'notes', to: 'assignees#notes'
      resources :notes, only: [:new, :create, :edit, :update, :destroy]
    end

    # Routes for wizard sign-up
    resources :after_sign_up

  end

end
