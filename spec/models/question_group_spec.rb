# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionGroup, type: :model do
  it { is_expected.to belong_to :survey }
  it { is_expected.to have_many :questions }
  it { is_expected.to validate_presence_of :survey }
end
