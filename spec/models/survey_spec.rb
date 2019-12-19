# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Survey, type: :model do
  it { is_expected.to have_many :question_groups }
  it { is_expected.to have_many :survey_entries }
  it { is_expected.to validate_presence_of :active_from }
  it { is_expected.to validate_presence_of :active_to }
  it { is_expected.to validate_presence_of :title }
end
