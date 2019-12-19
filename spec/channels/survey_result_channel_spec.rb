# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveyResultChannel, type: :channel do
  let(:survey) { create :survey }

  it 'can subscribe' do
    subscribe(survey_id: survey.id)
    expect(subscription).to be_confirmed
  end
end
