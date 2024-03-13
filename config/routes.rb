# frozen_string_literal: true

Rails.application.routes.draw do
  resources :people do
    resources :details
  end
  get 'people-details/:id', to: 'people#details', as: :person_details_by_turbo
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'people#index'
end