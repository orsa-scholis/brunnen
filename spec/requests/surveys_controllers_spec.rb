# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveysController, type: :request do
  describe 'index' do
    subject { response }

    let!(:surveys) { create_pair :survey }

    before { get surveys_path }

    it { is_expected.to be_successful }

    it 'renders title' do
      expect(response.body).to include(I18n.t('root.all_surveys'))
    end

    it 'renders all surveys' do
      expect(response.body).to include(*surveys.map(&:title))
    end

    context 'when there are also inactive surveys' do
      let!(:inactive_survey) { create :survey, title: 'Inactive' }

      it 'does not render inactive survey' do
        expect(response.body).not_to include inactive_survey.title
      end

      context 'when an admin is signed in' do
        before { sign_in create(:administrator) }

        it 'renders inactive survey' do
          expect(response.body).not_to include inactive_survey.title
        end
      end
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
