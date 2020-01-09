# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubmissionTracking, type: :model do
  let(:submission_tracking) { described_class.new(survey_entries: survey_entries) }
  let(:survey_entries) { [] }

  describe '#<<' do
    before { submission_tracking << build_stubbed(:survey_entry) }

    it 'adds a survey entry to its list' do
      expect(submission_tracking.survey_entries.length).to eq 1
    end
  end
end
