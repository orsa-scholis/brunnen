# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerPossibilityGroup, type: :model do
  it { is_expected.to have_many :answer_possibilities }
end
