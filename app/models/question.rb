# frozen_string_literal: true

class Question < ApplicationRecord
  has_and_belongs_to_many :answer_possibilities
  has_many :answers, dependent: :destroy
  has_one :survey, through: :question_group, inverse_of: :questions

  belongs_to :question_group, inverse_of: :questions

  validates :question_group, presence: true

  translates :description
  globalize_accessors
end
