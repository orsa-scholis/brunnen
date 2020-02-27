# frozen_string_literal: true

FactoryBot.define do
  factory :question_group do
    survey
    sequence(:description) { |i| "My QuestionGroup #{i}" }
    questions { build_pair :question }
  end
end
