# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :answer_possibility
  belongs_to :survey_entry
  belongs_to :question
end
