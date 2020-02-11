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
end
