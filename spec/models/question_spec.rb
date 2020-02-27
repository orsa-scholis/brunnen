# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  it { is_expected.to have_and_belong_to_many :answer_possibilities }
  it { is_expected.to belong_to :question_group }
  it { is_expected.to have_many :answers }
  it { is_expected.to validate_presence_of :question_group }

  describe '#answer_possibility_counts' do
    include_context 'with completely filled out survey'

    it 'returns the count of the submitted survey entries per answer possibility', :aggregate_failures do
      expect(questions.first.answer_possibility_counts).to eq [2, 1, 1, 1]
      expect(questions.third.answer_possibility_counts).to eq [3, 2]
    end
  end
end
