# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveysController, type: :request do
  describe 'index' do
    it 'returns 200 status code' do
      get surveys_path
      expect(response).to have_http_status(:ok)
    end
  end
end
