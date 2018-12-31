require 'sidekiq/web'

Rails.application.routes.draw do
  resources :lesson_links
  
  resources :courses do
    resources :lessons, only: [:new, :create]
    resources :purchases, only: [:new, :create]
  end
  resources :lessons, only: [:show, :index, :edit, :update, :destroy]

  namespace :admin do
      resources :users
      resources :announcements
      resources :notifications
      resources :services

      root to: "users#index"
    end

  get '/support', to: 'home#support'
  get '/terms', to: 'home#terms'
  get '/privacy', to: 'home#privacy'
  get '/about', to: 'home#about'
  get '/pricing', to: 'home#pricing'
  get '/review', to: 'home#review'
  get '/tools', to: 'home#tools'
  get '/blog', to: 'home#blog'
  get '/permit', to: 'home#permit'
  get '/designs', to: 'home#designs'
  get '/podcast', to: 'home#podcast'
  get '/merch', to: 'home#merch'

  post '/newsletter', to: 'mailchimp#newsletter', as: 'newsletter'

  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
