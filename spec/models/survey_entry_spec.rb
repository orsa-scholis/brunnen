# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveyEntry, type: :model do
  it { is_expected.to have_many :answers }
  it { is_expected.to belong_to :survey }

  describe 'broadcast statistics sending' do
    let(:survey_entry) { build :survey_entry }

    it 'enqueues a broadcasting job' do
      expect { survey_entry.save }.to(
        have_enqueued_job(BroadcastSurveyStatsJob)
        .with(survey_entry.survey)
        .on_queue('broadcasts')
      )
    end
  end
end
