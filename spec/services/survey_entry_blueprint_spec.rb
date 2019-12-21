# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveyEntryBlueprint, type: :service do
  describe '#survey_entry' do
    subject(:survey_entry) { described_class.new(survey).survey_entry }

    let(:survey) { create :survey }
    let!(:question_groups) do
      [
        create(:question_group, survey: survey, questions: build_pair(:question)),
        create(:question_group, survey: survey, questions: build_pair(:question))
      ]
    end

    it 'generates a new survey entry with prebuilt answers', :aggregate_failures do
      expect(survey_entry.answers.length).to eq 4
      expect(survey_entry.answers.map(&:question)).to contain_exactly(*question_groups.map(&:questions).flatten)
    end
  end
end
