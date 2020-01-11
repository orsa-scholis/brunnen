# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveysHelper, type: :helper do
  describe '#survey_list_link' do
    subject(:survey_list_link) { helper.survey_list_link(survey, submission_tracking) }

    let(:administrator) { create :administrator }
    let(:survey) { build_stubbed :survey }
    let(:submission_tracking) { SubmissionTracking.new(survey_entries: survey_entries) }
    let(:survey_entries) { [] }

    it 'returns an active survey list link item', :aggregate_failures do
      expect(survey_list_link).to match(%r{<a[^>]+class=".+>[^<]*#{survey.title}[^<]*</a>})
      expect(survey_list_link).to include('list-group-item')
      expect(survey_list_link).to include("href=\"#{survey_entries_path(survey)}\"")
    end

    context 'when survey was already submitted' do
      let(:survey_entries) { [build(:survey_entry, survey: survey)] }

      it 'returns a disabled survey list link item', :aggregate_failures do
        expect(survey_list_link).to match(%r{<div.*#{survey.title}.*</div>}m)
        expect(survey_list_link).to include('text-muted', 'fas fa-check')
        expect(survey_list_link).not_to include('href')
      end

      context 'when an administrator is signed in' do
        before { sign_in administrator }

        it 'returns an active link with enhanced information', :aggregate_failures do
          expect(survey_list_link).to match(%r{<a.*</a>}m)
          expect(survey_list_link).to include('badge badge-success badge-pill')
          expect(survey_list_link).to include(I18n.t('activerecord.attributes.survey.active'))
        end
      end
    end

    context 'when survey is inactive' do
      before { allow(survey).to receive(:active?).and_return false }

      it 'returns nil' do
        expect(survey_list_link).to be_nil
      end

      context 'when an administrator is signed in' do
        before { sign_in administrator }

        it 'returns an inactive survey list link item', :aggregate_failures do
          expect(survey_list_link).to match(%r{<a.*</a>}m)
          expect(survey_list_link).to include 'list-group-item-secondary'
          expect(survey_list_link).to include(I18n.t('activerecord.attributes.survey.inactive'))
        end
      end
    end
  end
end
