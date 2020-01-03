# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveysController, type: :request do
  context 'when an administrator is signed in' do
    let(:administrator) { create :administrator }

    before { sign_in administrator }

    describe '#export' do
      include_context 'with completely filled out survey'

      let(:request) { post export_admin_survey_path(survey) }
      let(:content_disposition) { response.headers['Content-Disposition'] }

      before { request }

      it 'returns successful response' do
        expect(response).to be_successful
      end

      it 'returns correct content disposition' do
        expect(content_disposition).to match(/attachment/)
        expect(content_disposition).to match(/filename="export\.xlsx"/)
      end

      it 'renders correct view' do
        expect(response).to render_template 'admin/surveys/export.xlsx'
      end
    end
  end

  context 'when no administrator is signed in' do
    describe '#export' do
      let(:survey) { create :survey }

      before { post export_admin_survey_path(survey) }

      it 'redirects back' do
        expect(response).to redirect_to new_administrator_session_path
      end
    end
  end
end
