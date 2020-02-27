class CreateSurveyEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :survey_entries do |t|
      t.references :survey

      t.timestamps
    end
  end
end
