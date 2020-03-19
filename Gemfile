# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'administrate', github: 'orsa-scholis/administrate', branch: 'master'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'caxlsx_rails'
gem 'devise'
gem 'figaro'
gem 'globalize'
gem 'globalize-accessors'
gem 'httparty'
gem 'i18n-tasks'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'
gem 'rails', '~> 6.0.2.2'
gem 'rails-i18n'
gem 'rqrcode'
gem 'scenic'
gem 'sidekiq'
gem 'simple_form'
gem 'turbolinks', '~> 5'
gem 'validates_timeliness', '~> 5.0.0.alpha3'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'brakeman', require: false
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails', '= 4.0.0.beta3'
  gem 'rubocop'
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :production do
  gem 'lograge'
  gem 'redis'
  gem 'sentry-raven'
end

group :test do
  gem 'capybara'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'webmock'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
