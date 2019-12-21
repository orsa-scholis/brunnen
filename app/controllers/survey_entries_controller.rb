# frozen_string_literal: true

class SurveyEntriesController < ApplicationController
  before_action :load_survey

  def index
    @survey_entry = SurveyEntryBlueprint.new(@survey).survey_entry
    @grouped_answers = @survey_entry.answers.group_by { |answer| answer.question.question_group }
  end

  def create
    @survey.survey_entries.create
  end

  private

  def load_survey
    @survey = Survey.find(params[:survey_id])
  end
end
