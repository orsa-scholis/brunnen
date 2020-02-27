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
    let(:question_group) { create :question_group, survey: survey, questions: [] }
    let(:answer_possibilities) { (1..3).reverse_each.map { |value| build(:answer_possibility, value: value) } }
    let!(:question) do
      create :question, question_group: question_group, answer_possibilities: answer_possibilities
    end

    let(:answers) do
      answer_possibilities.map { |possibility| build :answer, question: question, answer_possibility: possibility }
    end

    before do
      answers.each do |answer|
        create :survey_entry, survey: survey, answers: [answer]
      end
    end

    it 'returns service statistics averages' do
      expect(service_statistics.averages).to eq(question_group => 2.0)
    end

    it 'return correct service statistics survey' do
      expect(service_statistics.survey).to eq survey
    end
  end

  context 'when there is multiple question groups with multiple answers' do
    let!(:questions) { question_groups.map { |group| group.questions.first } }
    let(:question_groups) do
      answer_possibilities.map do |possibility|
        create(:question_group,
               survey: survey,
               questions: [build(:question, answer_possibilities: possibility)])
      end
    end

    let(:answer_possibilities) do
      [
        (1..3).reverse_each.map { |value| build(:answer_possibility, value: value) },
        (0..2).reverse_each.map { |value| build(:answer_possibility, value: value) }
      ]
    end

    let(:answers_1) do
      answer_possibilities.first.map do |possibility|
        build(:answer, question: questions.first, answer_possibility: possibility)
      end
    end

    let(:answers_2) do
      answer_possibilities.second.map do |possibility|
        build(:answer, question: questions.second, answer_possibility: possibility)
      end
    end

    let(:expected_hash) { { question_groups.first => 2.0, question_groups.second => 1.0 } }

    before do
      answers_1.zip(answers_2).each do |answer_pair|
        create :survey_entry, survey: survey, answers: answer_pair
      end
    end

    it 'returns correct service statistics averages' do
      expect(service_statistics.averages).to eq(expected_hash)
    end

    it 'return correct service statistics survey' do
      expect(service_statistics.survey).to eq survey
    end
  end
end
