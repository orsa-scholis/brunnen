# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveyEntriesController, type: :request do
  describe 'index' do
    let(:request) { get survey_entries_path(survey) }

    describe 'content' do
      subject(:body) { response.body }

      let(:survey) { create :survey }

      before { request }

      it 'renders survey title' do
        expect(body).to include survey.title
      end
    end

    context 'with complete survey' do
      include_context 'with complete survey'

      it_behaves_like 'preventing display of inactive or already submitted surveys'
    end
  end

  describe 'create' do
    include_context 'with complete survey'

    let(:post_request) { post survey_entries_path(survey, params: params) }
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
        expect { post_request }.to change(SurveyEntry, :count)
        expect(SurveyEntry.last.answers.count).to eq 4
        expect(response).to redirect_to root_path(locale: :de)
        expect(flash[:notice]).to eq I18n.t('flashes.survey.create.successful')
      end

      it 'creates a cookie' do
        post_request
        expect(response.cookies[SubmissionTracking::COOKIE_IDENTIFIER]).to be_present
      end

      it_behaves_like 'preventing submission of inactive or already submitted surveys'
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
        expect { post_request }.not_to change(SurveyEntry, :count)
        expect(flash[:alert]).to eq I18n.t('flashes.survey.create.failure')
      end
    end
  end
end
