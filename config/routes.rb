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
end
