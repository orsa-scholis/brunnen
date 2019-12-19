# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Survey, type: :model do
  it { is_expected.to have_many :question_groups }
  it { is_expected.to have_many :survey_entries }
  it { is_expected.to validate_presence_of :active_from }
  it { is_expected.to validate_presence_of :active_to }
  it { is_expected.to validate_presence_of :title }

  describe '#active_to' do
    subject do
      described_class.new(active_from: active_from,
                          active_to: active_to)
                     .tap(&:validate).errors.added?(:active_to, :after, restriction: '2019-12-16 10:00:00')
    end

    let(:active_from) { DateTime.parse '16.12.2019 10:00:00' }
    let(:active_to) { DateTime.parse '16.12.2019 18:00:00' }

    context 'when active_to is after active_from' do
      it { is_expected.to be false }
    end

    context 'when active_to is at active_from' do
      let(:active_to) { active_from }

      it { is_expected.to be true }
    end

    context 'when active_to is before active_from' do
      let(:active_to) { DateTime.parse '16.12.2019 08:00:00' }

      it { is_expected.to be true }
    end
  end

  describe '#active' do
    context 'when there is an active Survey' do
      before do
        create :survey, :inactive
      end

      let!(:active_survey) { create :survey }

      it 'returns the active one' do
        expect(described_class.active).to eq [active_survey]
      end
    end

    context 'when there is no active Survey' do
      before do
        create :survey, :inactive
      end

      it 'returns the active one' do
        expect(described_class.active).to eq []
      end
    end
  end
end
