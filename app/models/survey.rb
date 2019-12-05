# frozen_string_literal: true

class Survey < ApplicationRecord
  has_many :question_groups, inverse_of: :survey, dependent: :destroy
  has_many :survey_entries, inverse_of: :survey, dependent: :destroy

  translates :title
  globalize_accessors
end
