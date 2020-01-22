# frozen_string_literal: true

class AnswerPossibilitySubmission < ApplicationRecord
  belongs_to :question_group

  def readonly?
    true
  end
end
