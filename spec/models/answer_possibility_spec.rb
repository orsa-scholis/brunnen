# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerPossibility, type: :model do
  it { is_expected.to have_and_belong_to_many :questions }
  it { is_expected.to have_many :answers }

  it { is_expected.to validate_presence_of :value }
  it { is_expected.to validate_presence_of :description_de }
end
