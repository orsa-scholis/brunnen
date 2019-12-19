# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  it { is_expected.to have_and_belong_to_many :answer_possibilities }
  it { is_expected.to belong_to :question_group }
  it { is_expected.to have_many :answers }
  it { is_expected.to validate_presence_of :question_group }
end
