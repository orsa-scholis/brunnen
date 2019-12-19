# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  root 'surveys#index'

  devise_for :administrators

  authenticate :administrator do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :surveys, only: :index do
    resources :survey_entries, only: %i[index create], as: 'entries'
    get 'dashboard', to: 'dashboards#index', on: :member
  end

  namespace :admin do
    resources :questions
    resources :question_groups
    resources :answer_possibilities
    resources :answers
    resources :survey_entries
    resources :surveys

    root to: 'questions#index'
  end
end
