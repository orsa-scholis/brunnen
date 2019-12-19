# frozen_string_literal: true

class Question < ApplicationRecord
  has_and_belongs_to_many :answer_possibilities
  has_many :answers, dependent: :destroy

  belongs_to :question_group, inverse_of: :questions

  translates :description
  globalize_accessors
end
