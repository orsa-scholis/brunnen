# frozen_string_literal: true

class SurveyEntry < ApplicationRecord
  belongs_to :survey, inverse_of: :survey_entries
  has_many :answers

  validates :survey, presence: true
  validate :entry_completeness, if: -> { [survey, answers].all?(&:present?) }

  after_create_commit :broadcast_statistics

  accepts_nested_attributes_for :answers

  private

  def broadcast_statistics
    BroadcastSurveyStatsJob.perform_later survey
  end

  def entry_completeness
    question_ids = survey.questions.pluck(:id)

    if answers.count != question_ids.length
      return unless answer_length_valid?(question_ids)
    end

    errors.add(:answers, :not_all_answered) unless all_questions_answered? question_ids
  end

  def answer_length_valid?(question_ids)
    question_count = question_ids.length

    if answers.size < question_count
      errors.add(:answers, :too_short, count: question_count)
      return false
    end

    if answers.size > question_count
      errors.add(:answers, :too_long, count: question_count)
      return false
    end

    true
  end

  def all_questions_answered?(question_ids)
    answered_question_ids = answers.map(&:question_id)

    (question_ids - answered_question_ids).empty?
  end
end
