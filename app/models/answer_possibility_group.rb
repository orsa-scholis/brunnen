# frozen_string_literal: true

class AnswerPossibilityGroup < ApplicationRecord
  has_many :answer_possibilities, dependent: :nullify

  validates :description, presence: true
end
