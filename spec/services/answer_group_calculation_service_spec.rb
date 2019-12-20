# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerGroupCalculationService, type: :service do
  subject(:service_statistics) { described_class.new(survey).calculate }

  let(:survey) { create :survey }

  context 'when there is no question group' do
    it 'return empty service statistics averages' do
      expect(service_statistics.averages).to be_empty
    end

    it 'return correct service statistics survey' do
      expect(service_statistics.survey).to eq survey
    end
  end

  context 'when there is one question group with one answer' do
    let!(:question_group) { create :question_group, survey: survey, questions: [] }
    let(:answer_possibility) { build :answer_possibility, value: 3 }
    let!(:question) do
      create :question, question_group: question_group, answer_possibilities: [answer_possibility]
    end
    let!(:answer) do
      build :answer, question: question, answer_possibility: answer_possibility
    end

    before { create :survey_entry, survey: survey, answers: [answer] }

    it 'return empty service statistics averages' do
      expect(service_statistics.averages).to eq(question_group => 3.0)
    end

    it 'return correct service statistics survey' do
      expect(service_statistics.survey).to eq survey
    end
  end

  context 'when there is one question group with multiple answers' do
    let!(:question_group) { create :question_group, survey: survey, questions: [] }
    let(:answer_possibility_3) { build :answer_possibility, value: 3 }
    let(:answer_possibility_2) { build :answer_possibility, value: 2 }
    let(:answer_possibility_1) { build :answer_possibility, value: 1 }
    let!(:question) do
      create :question, question_group: question_group,
                        answer_possibilities: [
                          answer_possibility_1,
                          answer_possibility_2,
                          answer_possibility_3
                        ]
    end
    let!(:answer_1) do
      build :answer, question: question, answer_possibility: answer_possibility_1
    end
    let!(:answer_2) do
      build :answer, question: question, answer_possibility: answer_possibility_2
    end
    let!(:answer_3) do
      build :answer, question: question, answer_possibility: answer_possibility_3
    end

    before do
      create :survey_entry, survey: survey, answers: [answer_1, answer_2, answer_3]
    end

    it 'return empty service statistics averages' do
      expect(service_statistics.averages).to eq(question_group => 2.0)
    end

    it 'return correct service statistics survey' do
      expect(service_statistics.survey).to eq survey
    end
  end

  context 'when there is multiple question groups with multiple answers' do
    let!(:question_group_1) { create :question_group, survey: survey, questions: [] }
    let!(:question_group_2) { create :question_group, survey: survey, questions: [] }

    # QUESTION GROUP 1
    let(:answer_possibilities_1) do
      [
        build(:answer_possibility, value: 3), build(:answer_possibility, value: 2), build(:answer_possibility, value: 1)
      ]
    end
    let!(:question_1) do
      create :question, question_group: question_group_1, answer_possibilities: answer_possibilities_1
    end
    let!(:answers_1) do
      [
        build(:answer, question: question_1, answer_possibility: answer_possibilities_1.first),
        build(:answer, question: question_1, answer_possibility: answer_possibilities_1.second),
        build(:answer, question: question_1, answer_possibility: answer_possibilities_1.third)
      ]
    end
    # END QUESTION GROUP 1

    # QUESTION GROUP 2
    let(:answer_possibilities_2) do
      [
        build(:answer_possibility, value: 2), build(:answer_possibility, value: 1), build(:answer_possibility, value: 0)
      ]
    end
    let!(:question_2) do
      create :question, question_group: question_group_2, answer_possibilities: answer_possibilities_2
    end
    let!(:answers_2) do
      [
        build(:answer, question: question_2, answer_possibility: answer_possibilities_2.first),
        build(:answer, question: question_2, answer_possibility: answer_possibilities_2.second),
        build(:answer, question: question_2, answer_possibility: answer_possibilities_2.third)
      ]
    end
    # END QUESTION GROUP 2

    let(:expected_hash) { { question_group_1 => 2.0, question_group_2 => 1.0 } }

    before { create :survey_entry, survey: survey, answers: answers_1 + answers_2 }

    it 'return empty service statistics averages' do
      expect(service_statistics.averages).to eq(expected_hash)
    end

    it 'return correct service statistics survey' do
      expect(service_statistics.survey).to eq survey
    end
  end
end
