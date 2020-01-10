# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubmissionTracking, type: :model do
  let(:submission_tracking) { described_class.new(survey_entries: survey_entries) }
  let(:survey_entries) { [] }

  describe '#<<' do
    before { submission_tracking << build_stubbed(:survey_entry) }

    it 'adds a survey entry to its list' do
      expect(submission_tracking.survey_entries.length).to eq 1
    end
  end

  describe '#submitted?' do
    subject(:submitted) { submission_tracking.submitted?(queried_survey) }

    let(:survey) { build :survey }
    let(:survey_entries) { [build(:survey_entry, survey: survey)] }

    context 'when a survey was already submitted' do
      let(:queried_survey) { survey }

      it 'returns true' do
        expect(submitted).to eq true
      end
    end

    context 'when a survey has not been submitted yet submitted' do
      let(:queried_survey) { build :survey }

      it 'returns true' do
        expect(submitted).to eq false
      end
    end
  end

  describe 'save' do
    subject(:save) { submission_tracking.save(cookies) }

    let(:cookies) { {} }
    let(:survey_entries) { create_pair(:survey_entry) }

    it 'sets a new cookie' do
      save
      expect(cookies).to include(
        SubmissionTracking::COOKIE_IDENTIFIER => { expires: be_a(ActiveSupport::TimeWithZone), value: be_a(String) }
      )
    end
  end

  describe '#decode' do
    subject(:decoded) { submission_tracking.decode(encoded) }

    let(:survey_entries) { create_pair :survey_entry }
    let(:encoded) { Base64.encode64(survey_entries.map(&:id).join(SubmissionTracking::DELIMITER)) }

    it 'decodes correctly' do
      expect(decoded).to eq survey_entries
    end

    context 'when a survey entry does not exist anymore' do
      let(:encoded) { Base64.encode64((survey_entries.map(&:id) + [121_212_121]).join(SubmissionTracking::DELIMITER)) }

      it 'decodes only existing ones' do
        expect(decoded).to eq survey_entries
      end
    end
  end

  describe '.load' do
    subject(:decoded) { described_class.load(SubmissionTracking::COOKIE_IDENTIFIER => encoded) }

    let(:survey_entries) { create_pair :survey_entry }
    let(:encoded) { Base64.encode64(survey_entries.map(&:id).join(SubmissionTracking::DELIMITER)) }

    it 'decodes correctly' do
      expect(decoded.survey_entries).to eq survey_entries
    end

    context 'when cookies are empty' do
      subject(:decoded) { described_class.load({}) }

      it 'returns new instance' do
        expect(decoded.survey_entries).to be_empty
      end
    end
  end
end
