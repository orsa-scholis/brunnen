# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { is_expected.to belong_to :answer_possibility }
  it { is_expected.to belong_to :survey_entry }
  it { is_expected.to belong_to :question }
  it { is_expected.to validate_presence_of :answer_possibility }
  it { is_expected.to validate_presence_of :question }
  it { is_expected.to validate_presence_of :survey_entry }
end
