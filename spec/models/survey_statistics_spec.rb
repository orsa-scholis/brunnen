# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveyStatistics, type: :model do
  it { is_expected.to validate_presence_of :survey }
  it { is_expected.to validate_presence_of :averages }

  describe '#export' do
    include_context 'with completely filled out survey'

    let(:survey_statistics) { AnswerGroupCalculationService.new(survey).calculate }
    let(:expected_hash) do
      {
        survey: survey.slice(:title, :id),
        averages: {
          group_labels: [
            nil, nil
          ],
          group_values: [
            3.0,
            0.0
          ],
          min: 0,
          max: 3
        }
      }
    end

    it 'exports expected values' do
      expect(AnswerGroupCalculationService.new(survey).calculate.export).to eq expected_hash
    end
  end

  describe '#to_json' do
    include_context 'with completely filled out survey'

    let(:survey_statistics) { AnswerGroupCalculationService.new(survey).calculate }
    let(:expected_json) do
      {
        survey: survey.slice(:title, :id),
        averages: {
          group_labels: [
            nil, nil
          ],
          group_values: %w[3.0 0.0],
          min: 0,
          max: 3
        }
      }.to_json
    end

    it 'exports expected values' do
      expect(AnswerGroupCalculationService.new(survey).calculate.to_json).to eq expected_json
    end
  end
end
