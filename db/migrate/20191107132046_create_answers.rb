class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.references :answer_possibility
      t.references :survey_entry
      t.references :question

      t.timestamps
    end
  end
end
