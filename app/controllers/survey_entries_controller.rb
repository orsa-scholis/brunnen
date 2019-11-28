# frozen_string_literal: true

class SurveyEntriesController < ApplicationController
  before_action :load_survey

  def index
    @survey_entry = @survey.survey_entries.new
  end

  def create
    @survey.survey_entries.create
  end

  private

  def load_survey
    @survey = Survey.find(params[:survey_id])
  end
end
