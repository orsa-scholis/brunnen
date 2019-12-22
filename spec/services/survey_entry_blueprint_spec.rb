# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveyEntryBlueprint, type: :service do
  describe '#survey_entry' do
    include_context 'with complete survey'

    subject(:survey_entry) { described_class.new(survey).survey_entry }

    it 'generates a new survey entry with prebuilt answers', :aggregate_failures do
      expect(survey_entry.answers.length).to eq 4
      expect(survey_entry.answers.map(&:question)).to contain_exactly(*question_groups.map(&:questions).flatten)
    end
  end
end
