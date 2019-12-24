# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveyEntry, type: :model do
  describe 'validations' do
    it { is_expected.to have_many :answers }
    it { is_expected.to belong_to :survey }
    it { is_expected.to validate_presence_of :survey }

    describe 'entry_completeness validation' do
      include_context 'with complete survey'

      subject(:survey_entry) { build(:survey_entry, survey: survey, answers: answers).tap(&:validate) }

      let(:all_answers) do
        questions.map do |question|
          build(:answer, question: question, answer_possibility: question.answer_possibilities.sample)
        end
      end

      context 'when not all questions were answered' do
        let(:answers) { all_answers[0..-2] }

        it 'adds a length error' do
          expect(survey_entry.errors.added?(:answers, :too_short, count: 4)).to eq true
        end
      end

      context 'when all questions were answered' do
        let(:answers) { all_answers }

        it 'is valid' do
          expect(survey_entry).to be_valid
        end
      end

      context 'when there are answers which have never been asked...' do
        let(:some_other_survey) { create :survey }
        let(:never_asked_question_group) do
          create(:question_group, survey: some_other_survey)
        end

        let(:superfluous_answer) do
          build(:answer, question: question_nobody_asked_for, answer_possibility: AnswerPossibility.first)
        end

        let(:answers) { all_answers + [superfluous_answer] }
        let!(:question_nobody_asked_for) do
          create(:question, answer_possibilities: first_scale, question_group: never_asked_question_group)
        end

        it 'adds a length error' do
          expect(survey_entry.errors.added?(:answers, :too_long, count: 4)).to eq true
        end

        context 'when length matches but one question was never asked' do
          let(:answers) { all_answers[0..-2] + [superfluous_answer] }

          it 'adds a length error' do
            expect(survey_entry.errors.added?(:answers, :not_all_answered)).to eq true
          end
        end
      end
    end
  end

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
