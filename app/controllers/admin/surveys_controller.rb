# frozen_string_literal: true

module Admin
  class SurveysController < Admin::ApplicationController
    def export
      @survey = Survey.includes(questions: [:answers]).find(requested_resource.id)

      render xlsx: 'admin/surveys/export.xlsx'
    end

    private

    def export_locals
      { page: Administrate::Page::Show.new(dashboard, requested_resource) }
    end
  end
end
