class AddShortUrlCachingToSurvey < ActiveRecord::Migration[6.0]
  def change
    add_column :surveys, :short_url, :string
  end
end
