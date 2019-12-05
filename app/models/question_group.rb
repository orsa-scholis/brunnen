# frozen_string_literal: true

class QuestionGroup < ApplicationRecord
  belongs_to :survey, inverse_of: :question_groups

  has_many :questions

  translates :description
  globalize_accessors
end
