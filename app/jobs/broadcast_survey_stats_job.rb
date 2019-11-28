# frozen_string_literal: true

class BroadcastSurveyStatsJob < ApplicationJob
  queue_as :default

  def perform(survey)
    SurveyResultChannel.broadcast_to(survey, 'message': 'testing')
  end
end
