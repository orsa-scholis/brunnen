class CreateAnswerPossibilitySubmissions < ActiveRecord::Migration[6.0]
  def change
    create_view :answer_possibility_submissions
  end
end
