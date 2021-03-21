Rails.application.routes.draw do
  devise_for :authors, controllers: { :omniauth_callbacks => "authors/omniauth_callbacks" }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  resources :posts
  resources :comments
end
