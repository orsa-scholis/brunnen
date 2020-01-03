# frozen_string_literal: true

class Question < ApplicationRecord
  has_and_belongs_to_many :answer_possibilities
  has_many :answers, dependent: :destroy
  has_one :survey, through: :question_group, inverse_of: :questions

  belongs_to :question_group, inverse_of: :questions

  validates :question_group, presence: true

  translates :description
  globalize_accessors

  def answer_possibility_counts
    answer_possibilities.map do |answer_possibility|
      answers.where(answer_possibility_id: answer_possibility.id).count
    end
  end

  # def answer_possibilities_min_value
  #  answer_possibilities.min(&:value).value
  # end
  #
  # def answer_possibilities_max_value
  #  answer_possibilities.max(&:value).value
  # end
end
