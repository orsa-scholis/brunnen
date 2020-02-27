# frozen_string_literal: true

FactoryBot.define do
  factory :answer_possibility do
    value { 3 }
    sequence(:description) { |i| "My answer possibility #{i}" }
  end
end
