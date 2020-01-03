# frozen_string_literal: true

class BroadcastSurveyStatsJob < ApplicationJob
  queue_as :broadcasts

  def perform(survey)
    SurveyResultChannel.broadcast_to(survey, AnswerGroupCalculationService.new(survey).calculate.export)
  end
end
