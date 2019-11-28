class AnswerPossibilitiesQuestionsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :answer_possibilities, :questions
  end
end
