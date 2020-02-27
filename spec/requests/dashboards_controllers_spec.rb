# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DashboardsController, type: :request do
  let(:survey) { create :survey }

  describe 'index' do
    it 'sends ok status code' do
      get dashboard_survey_path(survey)
      expect(response).to have_http_status(:ok)
    end
  end
end
