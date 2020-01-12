# frozen_string_literal: true

class AnswerPossibility < ApplicationRecord
  has_and_belongs_to_many :questions
  has_many :answers, dependent: :destroy
  belongs_to :answer_possibility_group, required: false

  validates :value, :description_de, presence: true
  validates :value, numericality: { greater_than_or_equal_to: 0 }

  translates :description
  globalize_accessors
end
