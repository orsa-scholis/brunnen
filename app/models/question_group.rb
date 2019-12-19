# frozen_string_literal: true

class QuestionGroup < ApplicationRecord
  belongs_to :survey, inverse_of: :question_groups

  has_many :questions, dependent: :destroy, inverse_of: :question_group

  translates :description
  globalize_accessors
end
