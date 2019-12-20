# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveyStatistics, type: :model do
  it { is_expected.to validate_presence_of :survey }
  it { is_expected.to validate_presence_of :averages }
end
