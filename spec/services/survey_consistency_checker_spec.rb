# frozen_string_literal: true

require 'rails_helper'

def quote_string(string)
  "\"#{string}\""
end

RSpec.describe SurveyConsistencyChecker, type: :service do
  describe '#consistency_issues' do
    subject { service.consistency_issues }

    let(:service) { described_class.new(survey) }
    let(:survey) { create(:survey, question_groups: question_groups) }
    let(:question_groups) { [] }

    before { I18n.locale = :de }

    after { I18n.locale = I18n.default_locale }

    it { is_expected.to contain_exactly I18n.t('surveys.consistency_issues.no_question_groups') }

    context 'when it has empty question groups' do
      let(:question_group_description) { 'My very cool question group' }
      let(:question_groups) { [build(:question_group, description: question_group_description, questions: [])] }
      let(:error_message) do
        I18n.t('surveys.consistency_issues.empty_question_groups.one',
               question_groups: "\"#{question_group_description}\"")
      end

      it { is_expected.to contain_exactly error_message }

      context 'when it has two empty question groups' do
        let(:question_groups) { build_pair(:question_group, questions: []) }
        let(:descriptions) { question_groups.map(&:description).map(&method(:quote_string)) }
        let(:error_message) do
          I18n.t('surveys.consistency_issues.empty_question_groups.other',
                 question_groups: descriptions.join(' und '))
        end

        it { is_expected.to contain_exactly error_message }
      end
    end

    context 'when it has questions without any answer possibilities' do
      let(:question_groups) { [build(:question_group, questions: questions)] }
      let(:questions) { [build(:question, answer_possibilities: [])] }
      let(:description) { "\"#{questions.first.description}\"" }
      let(:error_message) { I18n.t('surveys.consistency_issues.no_answer_possibilities.one', questions: description) }

      it { is_expected.to contain_exactly error_message }

      context 'when it two empty questions' do
        let(:questions) { build_pair(:question, answer_possibilities: []) }
        let(:descriptions) { questions.map(&:description).map(&method(:quote_string)) }
        let(:error_message) do
          I18n.t('surveys.consistency_issues.no_answer_possibilities.other',
                 questions: descriptions.join(' und '))
        end

        it { is_expected.to contain_exactly error_message }
      end
    end

    context 'when survey is complete' do
      include_context 'with complete survey'

      it { is_expected.to be_empty }
    end
  end
end
