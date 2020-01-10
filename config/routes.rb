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
    resources :answer_possibility_groups
    resources :surveys do
      post 'export', to: 'surveys#export', on: :member
    end

    root to: 'questions#index'
  end
end
