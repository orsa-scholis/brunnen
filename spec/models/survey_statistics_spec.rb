# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveyStatistics, type: :model do
  it { is_expected.to validate_presence_of :survey }
  it { is_expected.to validate_presence_of :averages }

  describe '#export' do
    include_context 'with completely filled out survey'

    let(:survey_statistics) { AnswerGroupCalculationService.new(Survey.first).calculate }
    let(:expected_hash) do
      {
        survey: Survey.first.slice(:title, :id),
        averages: {
          group_labels: [
            'My awesome group'
          ],
          group_values: [
            4.0
          ],
          min: 0,
          max: 4
        }
      }
    end

    it 'exports expected values' do
      expect(AnswerGroupCalculationService.new(Survey.first).calculate.export).to eq expected_hash
    end
  end

  describe '#to_json' do
    include_context 'with completely filled out survey'

    let(:survey_statistics) { AnswerGroupCalculationService.new(Survey.first).calculate }
    let(:expected_json) do
      {
        survey: Survey.first.slice(:title, :id),
        averages: {
          group_labels: [
            'My awesome group'
          ],
          group_values: [
            '4.0'
          ],
          min: 0,
          max: 4
        }
      }.to_json
    end

    it 'exports expected values' do
      expect(AnswerGroupCalculationService.new(Survey.first).calculate.to_json).to eq expected_json
    end
  end
end
