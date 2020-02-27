# frozen_string_literal: true

FactoryBot.define do
  factory :question_group do
    survey
    questions { build_pair :question }
  end
end
