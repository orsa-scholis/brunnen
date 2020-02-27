# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveyStatistics, type: :model do
  it { is_expected.to validate_presence_of :survey }
  it { is_expected.to validate_presence_of :averages }

  describe '#export' do
    include_context 'with completely filled out survey'

    let(:first_scale) do
      [
        create(:answer_possibility, value: 0, description: 'first first'),
        create(:answer_possibility, value: 1, description: 'first second'),
        create(:answer_possibility, value: 2, description: 'first third'),
        create(:answer_possibility, value: 3, description: 'first last')
      ]
    end
    let(:second_scale) { first_scale }

    let(:survey_statistics) { AnswerGroupCalculationService.new(survey).calculate }
    let(:expected_hash) do
      {
        survey: survey.slice(:title, :id),
        averages: {
          group_labels: [
            nil, nil
          ],
          group_values: [
            1.2,
            1.2
          ],
          min: 0,
          max: 3,
          vote_options: {
            0 => 'first first',
            1 => 'first second',
            2 => 'first third',
            3 => 'first last'
          }
        }
      }
    end

    it 'exports expected values' do
      expect(AnswerGroupCalculationService.new(survey).calculate.export).to eq expected_hash
    end
  end

  describe '#to_json' do
    include_context 'with completely filled out survey'

    let(:first_scale) do
      [
        create(:answer_possibility, value: 0, description: 'first first'),
        create(:answer_possibility, value: 1, description: 'first second'),
        create(:answer_possibility, value: 2, description: 'first third'),
        create(:answer_possibility, value: 3, description: 'first last')
      ]
    end
    let(:second_scale) { first_scale }

    let(:survey_statistics) { AnswerGroupCalculationService.new(survey).calculate }
    let(:expected_json) do
      {
        survey: survey.slice(:title, :id),
        averages: {
          group_labels: [
            nil, nil
          ],
          group_values: %w[1.2 1.2],
          min: 0,
          max: 3,
          vote_options: {
            0 => 'first first',
            1 => 'first second',
            2 => 'first third',
            3 => 'first last'
          }
        }
      }.to_json
    end

    it 'exports expected values' do
      expect(AnswerGroupCalculationService.new(survey).calculate.to_json).to eq expected_json
    end
  end
end
