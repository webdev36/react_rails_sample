Rails.application.routes.draw do
  root to: 'pages#about'

  get '/home', to: 'pages#home'
  get '/about', to: 'pages#about'

  namespace :api do
    namespace :v1 do
      resources :events, only: [:index, :create, :update]
      resources :users, only: [:index]
      resources :subscriptions, only: [:create, :destroy]
      resources :followers, only: [:create, :destroy]
    end
  end

  resources :events, only: [:new]
  get '/events/:id-:slug', to: 'events#show', as: :event
  get '/events/:id-:slug/edit', to: 'events#edit', as: :event_edit
  get '/events/toggle_subscription/:id', to: 'events#toggle_subscription', as: :toggle_subscription
  get '/users/:id-:username', to: 'users#show', as: :user
  get '/users/toggle-following/:id', to: 'users#toggle_following', as: :toggle_following

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :users do
    get 'sign_in', to: 'pages#login_signup', as: :new_user_session
    get 'sign_in', to: 'pages#login_signup', as: :new_session
  end
  get '/users/logout', to: 'sessions#destroy', as: 'signout'

  authenticate :user, lambda { |u| u.admin? } do
    mount RailsAdmin::Engine => '/sadmin', as: 'rails_admin'
  end
end
