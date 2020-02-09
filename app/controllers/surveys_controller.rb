# frozen_string_literal: true

require 'concerns/submission_trackable'

class SurveysController < ApplicationController
  include SubmissionTrackable

  def index
    @surveys = (administrator_signed_in? ? Survey.all : Survey.active).descending
  end

  def qrcode
    @survey = Survey.find(params[:id])
    @qr_code = QrCodeService.new(@survey.short_url)

    render 'qrcode'
  end
end
