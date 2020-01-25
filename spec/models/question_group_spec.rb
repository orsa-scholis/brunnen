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
end
