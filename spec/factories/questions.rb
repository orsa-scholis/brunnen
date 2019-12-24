# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    answer_possibilities { build_pair :answer_possibility }
    description { 'My description' }
  end
end
