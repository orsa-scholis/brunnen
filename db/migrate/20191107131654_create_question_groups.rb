class CreateQuestionGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :question_groups do |t|
      t.string :description
      t.references :survey

      t.timestamps
    end
  end
end
