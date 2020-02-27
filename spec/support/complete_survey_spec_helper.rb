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

RSpec.shared_context 'with completely filled out survey' do
  let(:survey) { create :survey }

  let(:first_scale) { create_list(:answer_possibility, 4) }
  let(:second_scale) { create_list(:answer_possibility, 2, value: 0) }

  let(:first_questions) { build_pair(:question, answer_possibilities: first_scale) }
  let(:second_questions) { build_pair(:question, answer_possibilities: second_scale) }
  let(:questions) { first_questions + second_questions }

  let!(:question_groups) do
    [
      create(:question_group, survey: survey, questions: first_questions),
      create(:question_group, survey: survey, questions: second_questions)
    ]
  end

  before do
    5.times do |i|
      survey_entry = create :survey_entry, survey: survey

      first_index = i % first_scale.length
      second_index = i % second_scale.length

      create(:answer,
             survey_entry: survey_entry,
             answer_possibility: first_scale[first_index],
             question: first_questions.first)
      create(:answer,
             survey_entry: survey_entry,
             answer_possibility: first_scale[first_index],
             question: first_questions.second)

      create(:answer,
             survey_entry: survey_entry,
             answer_possibility: second_scale[second_index],
             question: second_questions.first)
      create(:answer,
             survey_entry: survey_entry,
             answer_possibility: second_scale[second_index],
             question: second_questions.second)
    end
  end
end
