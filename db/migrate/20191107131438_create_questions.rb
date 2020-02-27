class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.references :question_group
      t.references :answer_possibilities
      t.string :description

      t.timestamps
    end
  end
end
