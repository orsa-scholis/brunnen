class RemoveAnswerPossibilitiesIdFromQuestions < ActiveRecord::Migration[6.0]
  def change
    remove_column :questions, :answer_possibilities_id, :bigint
  end
end
