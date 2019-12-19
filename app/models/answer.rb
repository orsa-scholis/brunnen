# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :answer_possibility
  belongs_to :survey_entry
  belongs_to :question

  validates :answer_possibility, :question, :survey_entry, presence: true
end
