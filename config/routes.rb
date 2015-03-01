Rails.application.routes.draw do

  devise_for :users,
    controllers: { registrations: 'registrations', sessions: 'sessions' },
    path: '',
    path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}

  root 'pages#home'

  # Pages
  get 'pricing', to: 'pages#pricing'
  get 'about',   to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'pricing/custom-quote', to: 'pages#custom_quote'

  # Dashboard
  get 'dashboard', to: 'dashboard#index'

  # Organisation
  resources :organisations, only: %w( edit ) do
    get 'choose_phone_number', path: 'choose-phone-number'
    match 'activate_phone_number', path: 'activate-phone-number', via: :post
  end

  # Declared here so the path name organisation is not auto-created in the
  # resources block as it is needed for later
  match '/organisations/:id', to: 'organisations#update', via: :put
  match '/organisations/:id', to: 'organisations#update', via: :patch

  resources :customers do
    get 'assign_customer', path: 'assign-to/:user_id'
    get 'close_customer', path: 'close'
  end

  # Path for Twilio
  match 'get-sms', to: 'messages#get_sms', via: :post

  # Needs to be defined last to ensure all other roots take presendence
  get ':organisation_id', to: 'organisations#show', as: :organisation
  get ':organisation_id/signup',   to: 'organisations#new_customer',          as: :organisation_new_customer
  match ':organisation_id/signup', to: 'organisations#create_new_customer',   as: :organisation_create_customer, via: :post
  get ':organisation_id/thanks',   to: 'organisations#after_customer_signup', as: :organisation_after_signup
end
