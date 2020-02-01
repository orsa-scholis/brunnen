# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'surveys/index.html.erb', type: :view do
  subject { rendered }

  let(:submission_tracking) { instance_double(SubmissionTracking, submitted?: false) }
  let(:surveys) do
    [
      build_stubbed(:survey, id: 1),
      build_stubbed(:survey, id: 2)
    ]
  end

  before do
    assign(:surveys, surveys)
    assign(:submission_tracking, submission_tracking)
  end

  context 'when no administrator is signed in' do
    before { render }

    it { is_expected.to include I18n.t('root.active_surveys') }

    describe 'surveys list' do
      it 'renders the surveys list', :aggregate_failures do
        surveys.each do |survey|
          expect(rendered).to include survey.title
        end

        expect(rendered).not_to include I18n.t('root.no_active_surveys')
      end

      it 'renders links to survey form', :aggregate_failures do
        surveys.each { |survey| expect(rendered).to include survey_entries_path(survey) }
      end

      context 'when a survey was already submitted' do
        let(:submission_tracking) { instance_double(SubmissionTracking, submitted?: true) }

        it 'renders a check and no links', :aggregate_failures do
          expect(rendered).not_to include survey_entries_path(surveys.first)
          expect(rendered).not_to include survey_entries_path(surveys.second)
          expect(rendered).to include 'fas fa-check'
        end
      end

      context 'when list is empty' do
        let(:surveys) { [] }

        it 'renders a message' do
          expect(rendered).to include I18n.t('root.no_active_surveys')
        end
      end
    end
  end

  context 'when administrator is signed in' do
    before do
      sign_in create(:administrator)
      render
    end

    it { is_expected.to include I18n.t('root.all_surveys') }

    context 'when a survey was already submitted' do
      let(:submission_tracking) { instance_double(SubmissionTracking, submitted?: true) }

      it 'still renders the links', :aggregate_failures do
        surveys.each { |survey| expect(rendered).to include survey_entries_path(survey) }
        expect(rendered).not_to include 'fas fa-check'
      end
    end
  end
end
