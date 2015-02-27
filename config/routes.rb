Rails.application.routes.draw do

  devise_for :users,
    controllers: { registrations: 'registrations' },
    path: '',
    path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}

  root 'pages#home'

  # Pages
  get 'pricing', to: 'pages#pricing'
  get 'about',   to: 'pages#about'
  get 'contact', to: 'pages#contact'

  # Dashboard
  get 'dashboard', to: 'dashboard#index'

  # Organisation
  resources :organisations, only: %w( edit show update ) do
    get 'choose_phone_number', path: 'choose-phone-number'
    match 'activate_phone_number', path: 'activate-phone-number', via: :post
  end

  get 'new-customer', to: 'organisations#new_customer'

  resources :customers do
    get 'assign_customer', path: 'assign-to/:user_id'
    get 'close_customer', path: 'close'
  end

  match 'get-sms', to: 'messages#get_sms', via: :post
end
