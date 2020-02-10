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
      before { get qrcode_survey_path(survey) }

      it 'redirects to surveys list' do
        expect(response).to be_redirect
      end
    end

    context 'when there is an administrator signed in' do
      before { sign_in create(:administrator) }

      it 'returns 200 status code', :aggregate_failures do
        get qrcode_survey_path(survey)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include survey.title
      end
    end
  end
end
