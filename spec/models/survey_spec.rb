# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Survey, type: :model do
  it { is_expected.to have_many :question_groups }
  it { is_expected.to have_many :survey_entries }
  it { is_expected.to validate_presence_of :active_from }
  it { is_expected.to validate_presence_of :active_to }
  it { is_expected.to validate_presence_of :title }

  describe '#active_to' do
    subject { survey.tap(&:validate).errors.added?(:active_to, :after, restriction: active_from) }

    let(:survey) { build(:survey, active_from: active_from, active_to: active_to) }

    let(:active_from) { '2019-12-16 10:00:00' }
    let(:active_to) { '2019-12-16 18:00:00' }

    context 'when active_to is after active_from' do
      it { is_expected.to be false }
    end

    context 'when active_to is at active_from' do
      let(:active_to) { active_from }

      it { is_expected.to be true }
    end

    context 'when active_to is before active_from' do
      let(:active_to) { '2019-12-16 08:00:00' }

      it { is_expected.to be true }
    end
  end

  describe '#descending' do
    let!(:survey1) { create :survey }
    let!(:survey2) { create :survey, active_to: 3.hours.ago }
    let!(:survey3) { create :survey, active_to: 10.hours.ago }

    it 'returns the surveys in the correct order' do
      expect(described_class.descending).to eq [survey1, survey2, survey3]
    end
  end

  describe '#active?' do
    subject do
      survey.active?
    end

    context 'when the survey is active' do
      let(:survey) { create :survey }

      it { is_expected.to be true }
    end

    context 'when the survey is not active' do
      let(:survey) { create :survey, :inactive }

      it { is_expected.to be false }
    end
  end
end
