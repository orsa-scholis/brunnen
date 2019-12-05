# frozen_string_literal: true

class Question < ApplicationRecord
  has_and_belongs_to_many :answer_possibilities
  has_many :answers

  belongs_to :question_group

  translates :description
  globalize_accessors
end
