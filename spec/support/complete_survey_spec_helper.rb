# frozen_string_literal: true

RSpec.shared_context 'with complete survey' do
  let(:survey) { create :survey }

  let(:first_scale) { create_list(:answer_possibility, 4) }
  let(:second_scale) { create_list(:answer_possibility, 2) }

  let(:first_questions) { build_pair(:question, answer_possibilities: first_scale) }
  let(:second_questions) { build_pair(:question, answer_possibilities: second_scale) }
  let(:questions) { first_questions + second_questions }

  let!(:question_groups) do
    [
      create(:question_group, survey: survey, questions: first_questions),
      create(:question_group, survey: survey, questions: second_questions)
    ]
  end
end
