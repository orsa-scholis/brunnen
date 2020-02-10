# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveysController, type: :request do
  describe 'index' do
    it 'returns 200 status code' do
      get surveys_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'qrcode' do
    let(:survey) { create :survey }

    context 'when there is no administrator signed in' do
      it 'redirects to surveys list' do
        get qrcode_survey_path(survey)
        expect(response).to redirect_to(surveys_url(locale: I18n.locale))
      end
    end

    context 'when there is an administrator signed in' do
      before do
        sign_in create(:administrator)
      end

      it 'returns 200 status code' do
        get qrcode_survey_path(survey)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
