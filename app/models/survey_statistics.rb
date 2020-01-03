# frozen_string_literal: true

class SurveyStatistics
  include ActiveModel::Model

  attr_accessor :survey
  attr_accessor :averages

  validates :survey, :averages, presence: true

  def export
    pp averages.values
    # pp averages.keys.min(&:questions_min_value)
    # pp averages.keys.max(&:questions_max_value)

    {
      survey: survey.slice(:title, :id),
      averages: {
        group_labels: averages.keys.map(&:description),
        group_values: averages.values,
        min: 0, # averages.keys.min(&:questions_min_value).questions_min_value,
        max: 4 # averages.keys.max(&:questions_max_value).questions_max_value
      }
    }.to_json
  end
end
