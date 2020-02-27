# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'survey_entries/index.html.erb', type: :view do
  subject { rendered }

  let(:survey) { create(:survey) }
  let(:survey_entry) { SurveyEntryBlueprint.new(survey).survey_entry }

  before do
    assign(:survey_entry, survey_entry)
    assign(:grouped_answers, [])
  end

  context 'when no administrator is signed in' do
    before { render }

    it { is_expected.to have_content survey.title }
  end

  context 'when admin is signed in' do
    before do
      sign_in create(:administrator)
      render
    end

    it 'contains links to admin actions', :aggregate_failures do
      expect(rendered).to have_content I18n.t('dashboard')
      expect(rendered).to include dashboard_survey_path(survey)
      expect(rendered).to have_content I18n.t('edit')
      expect(rendered).to include edit_admin_survey_path(survey)
      expect(rendered).to have_content I18n.t('administrate.surveys.show.qrcode')
      expect(rendered).to include qrcode_survey_path(survey)
    end
  end
end
