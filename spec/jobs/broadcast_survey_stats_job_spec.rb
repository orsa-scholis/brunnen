# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BroadcastSurveyStatsJob, type: :job do
  let(:survey) { build :survey }

  describe '#perform' do
    subject(:perform) { described_class.new.perform(survey) }

    before { allow(SurveyResultChannel).to receive(:broadcast_to) }

    it 'sends broadcast to channel' do
      perform
      expect(SurveyResultChannel).to have_received(:broadcast_to).with(survey, 'message': 'testing')
    end
  end
end
