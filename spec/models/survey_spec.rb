# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Survey, type: :model do
  it { is_expected.to have_many :question_groups }
  it { is_expected.to have_many :survey_entries }
  it { is_expected.to validate_presence_of :active_from }
  it { is_expected.to validate_presence_of :active_to }
  it { is_expected.to validate_presence_of :title }

  describe '#active_to' do
    subject { model.tap(&:validate).errors.added? :active_to, :before_active_from }

    let(:active_from) { Time.zone.today.at_beginning_of_week }
    let(:active_to) { active_from.at_end_of_week - 2.days }

    context 'when active_to is after active_from' do
      it { is_expected.to be false }
    end

    context 'when active_to is at active_from' do
      let(:active_to) { active_from }

      it { is_expected.to be false }
    end

    context 'when active_to is before active_from' do
      let(:active_to) { active_from - 2.days }

      it { is_expected.to be true }
    end
  end
end
