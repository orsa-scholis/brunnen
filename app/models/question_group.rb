# frozen_string_literal: true

class QuestionGroup < ApplicationRecord
  belongs_to :survey, inverse_of: :question_groups, optional: true

  has_many :questions, dependent: :destroy, inverse_of: :question_group
  has_many :answer_possibility_submissions, dependent: :restrict_with_exception
  has_many :answers, through: :questions

  validate :survey_change_only_without_answers

  translates :description
  globalize_accessors

  scope :not_associated_or_with, ->(survey) { where(survey: survey).or(unscoped.not_associated) }
  scope :not_associated, -> { where(survey: nil) }

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

  def survey_change_only_without_answers
    return unless survey_id_changed? && persisted? && answers.any?

    errors.add(:survey_id, I18n.t('activerecord.errors.models.question_group.attributes.survey.change_with_answers'))
  end
end
