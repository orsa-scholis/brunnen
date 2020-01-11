# frozen_string_literal: true

module SurveysHelper
  def survey_list_link(survey, submission_tracking)
    return unless survey.active? || administrator_signed_in?
    return active_survey_list_entry(survey) if display_active_survey_list_entry?(submission_tracking, survey)

    submitted_survey_list_entry(survey)
  end

  def active_survey_list_class(survey)
    %W[
      list-group-item list-group-item-action
      d-flex justify-content-between align-items-center
      #{active_survey_state_class(survey)}
    ].join(' ')
  end

  private

  def display_active_survey_list_entry?(submission_tracking, survey)
    !submission_tracking.submitted?(survey) || administrator_signed_in?
  end

  def active_survey_state_class(survey)
    'list-group-item-secondary' unless survey.active?
  end

  def active_survey_list_entry(survey)
    render partial: 'surveys/list_items/active_survey_list_item', locals: { survey: survey }
  end

  def submitted_survey_list_entry(survey)
    render partial: 'surveys/list_items/submitted_survey_list_item', locals: { survey: survey }
  end
end
