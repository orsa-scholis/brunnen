# frozen_string_literal: true

module Admin
  class SurveysController < Admin::ApplicationController
    def export
      @survey = Survey.includes(questions: [:translations,
                                            answers: :answer_possibility,
                                            answer_possibilities: :translations]).find(requested_resource.id)

      render xlsx: 'admin/surveys/export.xlsx', filename: 'export.xlsx'
    end
  end
end
