# frozen_string_literal: true

module Admin
  class SurveysController < Admin::ApplicationController
    def export
      @survey = Survey.includes(questions: [:answers]).find(requested_resource.id)

      render xlsx: 'admin/surveys/export.xlsx', filename: 'export.xlsx'
    end
  end
end
