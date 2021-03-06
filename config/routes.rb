Rails.application.routes.draw do

  mount Attachinary::Engine => "/attachinary"

  # scope '(:locale)', locale: /fr/, default:  do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/, defaults: {locale: "en"} do
    root to: 'pages#home'

    devise_for :users, controllers: { registrations: 'registrations', confirmations: 'confirmations' }
    get 'confirm', to: 'pages#confirm'

    get 'about', to: 'pages#about'
    get 'contact', to: 'pages#contact'

    post '/subscribe', to: 'pages#subscribe'


    # Routes for core user side
    resources :users, only: [ :show, :edit, :update ] do

      # User Pages
      get 'profile', to: 'users#profile'
      get 'digital', to: 'users#digital'
      get 'children', to: 'users#children'
      get 'unlock', to: 'users#unlock'
      post 'unlock_data', to: 'users#unlock_data'
      resources :notes
      resources :proofs

      # Assignee Pages
      resources :assignees do
        get 'notes', to: 'assignees#notes'
      end

      # Guardian Pages
      resources :guardians, controller: 'assignees', type: 'Guardian' do
        get 'notes', to: 'assignees#notes'
      end

      # Recipient Pages
      resources :recipients, controller: 'assignees', type: 'Recipient' do
        get 'notes', to: 'assignees#notes'
      end

      # Routes for wizard sign-up
      resources :after_sign_up
    end
  end
end
