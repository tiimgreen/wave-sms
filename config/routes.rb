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

  resources :customers

  get 'get-sms', to: 'messages#get_sms'
end
