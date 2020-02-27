# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    question
    answer_possibility
    survey_entry
  end
end
