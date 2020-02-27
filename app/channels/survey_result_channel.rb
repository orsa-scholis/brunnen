# frozen_string_literal: true

class SurveyResultChannel < ApplicationCable::Channel
  def subscribed
    survey = Survey.find(params[:survey_id])
    stream_for survey
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
