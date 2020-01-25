# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScopedHasManyField do
  describe '#associated_resource_options' do
    subject(:associated_resource_options) do
      scoped_field.associated_resource_options
    end

    let(:scoped_field) do
      described_class.new('question_groups', data, 1)
    end

    let(:survey) { create :survey }
    let(:other_survey) { create :survey }
    let(:other_question_group) { create :question_group, survey: other_survey }

    let(:data) do
      create_list(:question_group, 2, survey: survey) + [other_question_group]
    end

    before do
    end

    context 'when there is no scope defined' do
      it 'does not scope' do
        expect(associated_resource_options.length).to eq(data.length)
      end
    end

    context 'when there is a scope defined' do
      let(:scoped_field) do
        p SurveyDashboard::QUESTION_GROUP_SCOPE

        described_class.new('question_groups', data, 'page')
                       .with_options(scope: SurveyDashboard::QUESTION_GROUP_SCOPE)
      end

      it 'does scope' do
        expect(associated_resource_options.length).to eq(data.length - 1)
      end
    end
  end
end
