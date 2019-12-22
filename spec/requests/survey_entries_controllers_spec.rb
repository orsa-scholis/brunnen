# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveyEntriesController, type: :request do
  include_context 'with complete survey'

  describe 'index' do
    before { get survey_entries_path(survey) }

    it 'returns 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders survey title' do
      expect(response.body).to include survey.title
    end
  end

  describe 'create' do
    let(:request) { post survey_entries_path(survey, params: params) }
    let(:answers_attributes) do
      [
        {
          question_id: first_questions.first.id,
          answer_possibility_id: first_questions.first.answer_possibilities.first.id
        },
        {
          question_id: first_questions.second.id,
          answer_possibility_id: first_questions.second.answer_possibilities.first.id
        },
        {
          question_id: second_questions.first.id,
          answer_possibility_id: second_questions.first.answer_possibilities.first.id
        },
        {
          question_id: second_questions.second.id,
          answer_possibility_id: second_questions.second.answer_possibilities.first.id
        }
      ]
    end

    context 'when params are valid' do
      let(:params) do
        {
          survey_entry: {
            answers_attributes: {
              '0': answers_attributes.first,
              '1': answers_attributes.second,
              '2': answers_attributes.third,
              '3': answers_attributes.fourth
            }
          },
          survey_id: survey.id
        }
      end

      it 'creates a new survey entry', :aggregate_failures do
        expect { request }.to change(SurveyEntry, :count)
        expect(SurveyEntry.last.answers.count).to eq 4
      end
    end

    context 'when params are invalid' do
      let(:params) do
        {
          survey_entry: {
            answers_attributes: {
              '0': answers_attributes.first,
              '1': answers_attributes.second,
              '3': answers_attributes.fourth
            }
          },
          survey_id: survey.id
        }
      end

      it 'does not create a new survey', :aggregate_failures do
        expect { request }.not_to change(SurveyEntry, :count)
      end
    end
  end
end
