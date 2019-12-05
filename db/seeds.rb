# frozen_string_literal: true

survey = Survey.create!(title: 'My cool survey')
group = QuestionGroup.create!(description: 'My awesome group', survey: survey)
unangenehm = AnswerPossibility.create!(value: -2, description: 'Sehr unangenehm')
mittel = AnswerPossibility.create!(value: -1, description: 'Naja')
neutral = AnswerPossibility.create!(value: 0, description: 'Ischt ok')
einigermassen_gut = AnswerPossibility.create!(value: 1, description: 'Einigermassen angenehm')
total_geil = AnswerPossibility.create!(value: 2, description: 'Ultra geil 😍')
yes = AnswerPossibility.create!(value: 1, description: 'Ja.')
no = AnswerPossibility.create!(value: -1, description: 'Nein?')

Question.create!(
  description: 'Empfindest du das Plätschern des Brunnens als angenehm?',
  question_group: group,
  answer_possibilities: [unangenehm, mittel, neutral, einigermassen_gut, total_geil]
)
second_question = Question.create!(
  description: 'Ist der Brunnen ästhetisch?',
  question_group: group,
  answer_possibilities: [yes, no]
)

philipps_entry_but_is_anonymous = SurveyEntry.create!

Answer.create!(
  [
    {
      survey_entry: philipps_entry_but_is_anonymous,
      answer_possibility: yes,
      question: second_question
    }
  ]
)
