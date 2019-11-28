# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  discard_on ActiveJob::DeserializationError

  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked
end
