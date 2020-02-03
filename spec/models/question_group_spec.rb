# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionGroup, type: :model do
  it { is_expected.to belong_to(:survey).required(false) }
  it { is_expected.to have_many :questions }
  it { is_expected.to have_many(:answer_possibility_submissions) }

  describe '#questions_min/max_possible_value' do
    context 'when there is a question' do
      let(:question_group) { create :question_group, questions: [question] }

      context 'with one answer_possibility' do
        let(:question) { build :question, answer_possibilities: [answer_possibility] }
        let(:answer_possibility) { build :answer_possibility, value: 2 }

        it 'returns the correct maximum' do
          expect(question_group.questions_max_possible_value).to eq 2
        end

        it 'returns the correct minimum' do
          expect(question_group.questions_min_possible_value).to eq 2
        end
      end

      context 'with multiple answer_possibilities' do
        let(:question) { build :question, answer_possibilities: [answer_possibility_1, answer_possibility_2] }
        let(:answer_possibility_1) { build :answer_possibility, value: 2 }
        let(:answer_possibility_2) { build :answer_possibility, value: 0 }

        it 'returns the correct maximum' do
          expect(question_group.questions_max_possible_value).to eq 2
        end

        it 'returns the correct minimum' do
          expect(question_group.questions_min_possible_value).to eq 0
        end
      end
    end
  end

  describe '#survey_change_only_without_answers' do
    context 'when the question_group gets created' do
      it 'creates without error' do
        expect { create :question_group }.to change { described_class.all.count }.by(1)
      end
    end

    context 'when the question_group gets updated' do
      let!(:question_group) { create :question_group }

      context 'when there is answers' do
        let(:new_survey) { create :survey }

        let(:questions) do
          create_pair :question, question_group: question_group
        end

        let(:answer_1) { create_pair :answer, question: questions.first }
        let(:answer_2) { create_pair :answer, question: questions.last }

        it 'adds an error to the question_group' do
          question_group.survey = new_survey
          question_group.valid?

          pp question_group.errors

          expect(question_group.errors[:survey_id])
            .to include(I18n.t('activerecord.errors.models.question_group.attributes.survey.change_with_answers'))
        end
      end

      context 'when there is no answers' do
        let(:new_description) { 'Neue Beschreibung' }

        before do
          question_group.update(description: new_description)
        end

        it 'updates the question_group' do
          expect(described_class.find(question_group.id).description).to eq(new_description)
        end
      end
    end
  end
end
