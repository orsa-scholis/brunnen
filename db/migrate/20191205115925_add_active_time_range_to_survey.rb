class AddActiveTimeRangeToSurvey < ActiveRecord::Migration[6.0]
  def change
    add_column :surveys, :active_from, :datetime
    add_column :surveys, :active_to, :datetime
  end
end
