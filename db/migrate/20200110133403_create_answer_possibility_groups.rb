class CreateAnswerPossibilityGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :answer_possibility_groups do |t|
      t.string :description, null: false
      t.timestamps
    end

    add_reference :answer_possibilities, :answer_possibility_group, index: true
  end
end
