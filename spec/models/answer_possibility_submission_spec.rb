# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerPossibilitySubmission, type: :model do
  it { is_expected.to belong_to(:question_group) }

  it 'is readonly' do
    expect(described_class.new.readonly?).to eq true
  end
end
