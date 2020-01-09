# frozen_string_literal: true

module SubmissionTrackable
  extend ActiveSupport::Concern

  included do
    before_action :load_submission_tracking
  end

  def load_submission_tracking
    @submission_tracking = SubmissionTracking.load(cookies)
  end

  def track_survey_submission(survey_entry)
    @submission_tracking << survey_entry
    @submission_tracking.save(cookies)
  end
end
