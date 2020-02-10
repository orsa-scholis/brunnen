# frozen_string_literal: true

FactoryBot.define do
  factory :survey do
    sequence(:title) { |i| "My Survey #{i}" }
    active_from { 1.day.ago }
    active_to { 2.hours.since }

    trait :inactive do
      active_to { 1.hour.ago }
    end
  end
end
