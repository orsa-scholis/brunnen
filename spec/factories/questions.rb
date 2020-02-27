# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    answer_possibilities { build_pair :answer_possibility }
    sequence(:description) { |i| "My question No. #{i}" }
  end
end
