# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    question_group
    association :answer_possibilities, factory: :answer_possibility
    description { 'My description' }
  end
end
