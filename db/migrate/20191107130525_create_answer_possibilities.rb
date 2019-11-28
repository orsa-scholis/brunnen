class CreateAnswerPossibilities < ActiveRecord::Migration[6.0]
  def change
    create_table :answer_possibilities do |t|
      t.integer :value
      t.string :description

      t.timestamps
    end
  end
end
