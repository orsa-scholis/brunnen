# frozen_string_literal: true

class SurveyStatistics
  include ActiveModel::Model

  attr_accessor :survey
  attr_accessor :averages

  validates :survey, :averages, presence: true

  def results?
    averages.values.any?
  end

  def export
    {
      survey: survey.slice(:title, :id),
      averages: {
        group_labels: averages.keys.map(&:description),
        group_values: averages.values,
        min: min_possible_value,
        max: max_possible_value,
        vote_options: group_vote_options
      }
    }
  end

  def to_json(*args)
    export.to_json(*args)
  end

  private

  def max_possible_value
    averages.keys.map(&:questions_max_possible_value).max
  end

  def min_possible_value
    averages.keys.map(&:questions_min_possible_value).min
  end

  def group_vote_options
    averages.keys.flat_map do |average|
      average.questions.flat_map do |question|
        question.answer_possibilities.flat_map do |answer_possibility|
          { answer_possibility.value => answer_possibility.description }
        end
      end
    end.uniq.reduce(&:merge)
  end
end
