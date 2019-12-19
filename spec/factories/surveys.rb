# frozen_string_literal: true

FactoryBot.define do
  factory :survey do
    title { 'My Survey' }
    active_from { '2019-12-15 10:00:00' }
    active_to { '2019-12-19 10:00:00' }
  end
end
