# frozen_string_literal: true

require 'concerns/submission_trackable'

class SurveyEntriesController < ApplicationController
  include SubmissionTrackable

  before_action :load_survey
  before_action :protect_from_resubmission!, unless: :administrator_signed_in?
  before_action :protect_from_inactive_surveys!, unless: :administrator_signed_in?

  def index
    @survey_entry = SurveyEntryBlueprint.new(@survey).survey_entry
    set_grouped_answers
  end

  def create
    @survey_entry = @survey.survey_entries.build survey_entry_params
    if @survey_entry.save
      track_survey_submission @survey_entry
      redirect_to root_path, notice: I18n.t('flashes.survey.create.successful', resource: @survey_entry)
    else
      set_grouped_answers
      flash[:alert] = I18n.t('flashes.survey.create.failure')
      render :index
    end
  end

  private

  def protect_from_inactive_surveys!
    raise ActiveRecord::RecordNotFound unless @survey.active?
  end

  def protect_from_resubmission!
    raise ActiveRecord::RecordNotFound if @submission_tracking.submitted?(@survey)
  end

  def set_grouped_answers
    @grouped_answers = @survey_entry.answers.group_by { |answer| answer.question.question_group }
  end

  def survey_entry_params
    params.require(:survey_entry).permit(answers_attributes: %i[answer_possibility_id question_id])
  end

  def load_survey
    @survey = Survey.find(params[:survey_id])
  end
end
