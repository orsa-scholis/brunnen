# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveyEntriesController, type: :request do
  let(:survey) { create :survey }

  describe 'index' do
    it 'returns 200 status code' do
      get survey_entries_path(survey)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'create' do
    let(:request) { post survey_entries_path(survey, params: params) }
    let(:params) do
      {}
    end

    it 'creates a new survey' do
      expect { request }.to change(SurveyEntry, :count)
    end
  end
end
