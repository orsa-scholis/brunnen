# frozen_string_literal: true

FactoryBot.define do
  factory :question_group do
    survey
    association :questions, factory: :question
  end
end
