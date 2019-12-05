class AddTranslations < ActiveRecord::Migration[6.0]
  def up
    remove_column :questions, :description
    remove_column :question_groups, :description
    remove_column :surveys, :title

    Question.create_translation_table! description: :string
    QuestionGroup.create_translation_table! description: :string
    Survey.create_translation_table! title: :string
  end

  def down
    Question.drop_translation_table!
    QuestionGroup.drop_translation_table!
    Survey.drop_translation_table!

    add_column :questions, :description, :string
    add_column :question_groups, :description, :string
    add_column :surveys, :title, :string
  end
end
