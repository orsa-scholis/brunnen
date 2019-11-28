# frozen_string_literal: true

class SurveyEntry < ApplicationRecord
  belongs_to :survey, inverse_of: :survey_entries
  has_many :answers

  after_create_commit :broadcast_stats

  private

  def broadcast_stats
    BroadcastSurveyStatsJob.perform_later survey
  end
end
