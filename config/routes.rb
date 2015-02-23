Rails.application.routes.draw do

  devise_for :users
  root 'pages#home'

  # Pages
  get 'pricing', to: 'pages#pricing'
  get 'about',   to: 'pages#about'
  get 'contact', to: 'pages#contact'

  # Dashboard
  get 'dashboard', to: 'dashboard#index'
end
