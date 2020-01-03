# frozen_string_literal: true

class QuestionGroup < ApplicationRecord
  belongs_to :survey, inverse_of: :question_groups

  has_many :questions, dependent: :destroy, inverse_of: :question_group

  validates :survey, presence: true

  translates :description
  globalize_accessors

  # def questions_min_value
  #  questions.min do |question_a, question_b|
  #    question_a.answer_possibilities_min_value <=> question_b.answer_possibilities_min_value
  #  end
  # end
  #
  # def questions_max_value
  #  questions.max(:answer_possibilities_max_value).answer_possibilities_max_value
  # end
  #
  # def questions_descriptions; end
end
