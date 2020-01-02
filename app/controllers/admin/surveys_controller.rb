# frozen_string_literal: true

module Admin
  class SurveysController < Admin::ApplicationController
    def export
      email = current_administrator.email

      flash[:notice] = I18n.t('administrate.surveys.show.flashes.preparing_export', email: email)

      SurveyExportJob.perform_later(email, requested_resource.id)

      render 'admin/surveys/show', locals: export_locals
    end

    private

    def export_locals
      { page: Administrate::Page::Show.new(dashboard, requested_resource) }
    end
  end
end
