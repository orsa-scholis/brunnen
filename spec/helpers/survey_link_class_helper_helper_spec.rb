# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::SurveyLinkClassHelper, type: :helper do
  describe '#link_classes' do
    subject { SurveyLinkClassHelper.link_classes(survey) }

    context 'when survey is active' do
      let(:survey) { create :survey }

      it { is_expected.to eq 'list-group-item list-group-item-action list-group-item-primary' }
    end

    context 'when survey is not active' do
      let(:survey) { create :survey, :inactive }

      it { is_expected.to eq 'list-group-item list-group-item-action list-group-item-secondary' }
    end
  end
end
