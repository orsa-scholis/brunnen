# frozen_string_literal: true

require 'sentry-raven'

Raven.configure do |config|
  config.dsn = ENV['SENTRY_DSN']
end
