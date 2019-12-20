class AddMoreTranslations < ActiveRecord::Migration[6.0]
  def up
    remove_column :answer_possibilities, :description

    AnswerPossibility.create_translation_table! description: :string
  end

  def down
    AnswerPossibility.drop_translation_table!

    add_column :answer_possibilities, :description, :string
  end
end
