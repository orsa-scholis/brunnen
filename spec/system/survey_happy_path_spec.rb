# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Survey happy path', type: :system do
  include_context 'with complete survey'

  let(:answers) do
    {
      questions.first => first_scale.first,
      questions.second => first_scale.second,
      questions.third => second_scale.first,
      questions.fourth => second_scale.second
    }
  end

  let(:submit_survey) { click_on I18n.t('helpers.submit.survey_entry.create') }

  after { I18n.locale = I18n.default_locale }

  it 'user can fill out surveys', :aggregate_failures do
    visit root_path
    click_on survey.title
    expect(page).to have_content survey.title

    answers.each do |question, answer|
      expect(page).to have_content question.description

      within("#question-#{question.id}") do
        choose answer.description
      end
    end

    expect { submit_survey }.to change(SurveyEntry, :count).by(1)
    expect(page).to have_content I18n.t('flashes.survey.create.successful')

    expect(find("i[title=\"#{I18n.t('surveys.index.tooltips.already_submitted')}\"]")).to be_visible
    expect(AnswerGroupCalculationService.new(survey).calculate.averages.values).to eq [3, 3]
  end

  it 'user can switch language', :aggregate_failures do
    visit root_path

    click_on I18n.t('languages.italian')
    expect(I18n.locale).to eq :it

    click_on I18n.t('languages.french')
    expect(I18n.locale).to eq :fr

    click_on I18n.t('languages.german')
    expect(I18n.locale).to eq :de
  end
end
