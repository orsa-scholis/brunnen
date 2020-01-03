# frozen_string_literal: true

FactoryBot.define do
  factory :administrator do
    sequence(:email) { |i| "my-meel#{i}@example.com" }
    password { '123456' }
  end
end
