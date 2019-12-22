# frozen_string_literal: true

class SurveyEntry < ApplicationRecord
  belongs_to :survey, inverse_of: :survey_entries
  has_many :answers

  validates :survey, presence: true
  validate :entry_completeness

  after_create_commit :broadcast_statistics

  accepts_nested_attributes_for :answers

  private

  def broadcast_statistics
    BroadcastSurveyStatsJob.perform_later survey
  end

  def entry_completeness
    question_ids = survey.questions.pluck(:id)

    return errors.add(:answers, :too_short, count: question_ids) if answers.count != question_ids.length

    errors.add(:answers, :not_all_answered) unless all_questions_answered? question_ids
  end

  def all_questions_answered?(question_ids)
    answered_question_ids = answers.pluck(:question_id)

    (question_ids - answered_question_ids).empty?
  end
end
