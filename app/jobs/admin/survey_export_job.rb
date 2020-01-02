# frozen_string_literal: true

module Admin
  class SurveyExportJob < ApplicationJob
    queue_as :default

    def perform(email, survey_id); end
  end
end
