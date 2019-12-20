# frozen_string_literal: true

class AnswerPossibility < ApplicationRecord
  has_and_belongs_to_many :questions
  has_many :answers, dependent: :destroy

  validates :value, :description_de, presence: true

  translates :description
  globalize_accessors
end
