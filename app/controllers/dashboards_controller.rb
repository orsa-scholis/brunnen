# frozen_string_literal: true

class DashboardsController < ApplicationController
  layout 'dashboards'

  before_action :load_survey

  def index; end

  private

  def load_survey
    @survey = Survey.find(params[:survey_id])
  end
end
