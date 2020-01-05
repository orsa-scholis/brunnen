# frozen_string_literal: true

class QuestionGroup < ApplicationRecord
  belongs_to :survey, inverse_of: :question_groups

  has_many :questions, dependent: :destroy, inverse_of: :question_group

  validates :survey, presence: true

  translates :description
  globalize_accessors

  def questions_min_possible_value
    questions.map do |question|
      question.answer_possibilities.minimum(:value)
    end.min
  end

  def questions_max_possible_value
    questions.map do |question|
      question.answer_possibilities.maximum(:value)
    end.max
  end
  #
  # def questions_descriptions; end
end
