# frozen_string_literal: true

require 'concerns/submission_trackable'

class SurveysController < ApplicationController
  include SubmissionTrackable

  def index
    @surveys = (administrator_signed_in? ? Survey.all : Survey.active).descending
  end
end
