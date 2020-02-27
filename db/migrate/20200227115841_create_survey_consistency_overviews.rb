class CreateSurveyConsistencyOverviews < ActiveRecord::Migration[6.0]
  def change
    create_view :survey_consistency_overviews
  end
end
