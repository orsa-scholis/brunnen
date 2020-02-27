# frozen_string_literal: true

class SurveyConsistencyOverview < ApplicationRecord
  belongs_to :survey, inverse_of: :survey_consistency_overviews
  belongs_to :question_group, inverse_of: :survey_consistency_overviews
  belongs_to :question, inverse_of: :survey_consistency_overview

  scope :valid_question_groups, -> { distinct.pluck(:question_group_id) }

  def readonly?
    true
  end
end
