# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveyConsistencyOverview, type: :model do
  it { is_expected.to belong_to :survey }
  it { is_expected.to belong_to :question_group }
  it { is_expected.to belong_to :question }

  it 'is a readonly model' do
    expect(described_class.new.readonly?).to eq true
  end
end
