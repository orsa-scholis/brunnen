# frozen_string_literal: true

class SurveyStatistics
  include ActiveModel::Model

  attr_accessor :survey
  attr_accessor :averages

  validates :survey, presence: true
end
