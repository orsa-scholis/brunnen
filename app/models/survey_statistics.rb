# frozen_string_literal: true

class SurveyStatistics
  include ActiveModel::Model

  attr_accessor :survey
  attr_accessor :averages

  validates :survey, :averages, presence: true

  def export
    {
      survey: survey.slice(:title, :id),
      averages: {
        group_labels: averages.keys.map(&:description),
        group_values: averages.values,
        min: min_possible_value,
        max: max_possible_value
      }
    }.to_json
  end

  private

  def max_possible_value
    averages.keys.map(&:questions_max_possible_value).max
  end

  def min_possible_value
    averages.keys.map(&:questions_min_possible_value).min
  end
end
