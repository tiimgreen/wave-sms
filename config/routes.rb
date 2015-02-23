Rails.application.routes.draw do

  devise_for :users
  root 'pages#home'

  get 'pricing', to: 'pages#pricing'
  get 'about',   to: 'pages#about'
  get 'contact', to: 'pages#contact'
end
