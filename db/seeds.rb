# frozen_string_literal: true

survey = Survey.create!(title: 'My cool survey', active_to: 1.week.since, active_from: 1.day.ago)
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
  description_fr: 'Trouvez-vous agréable l’éclaboussure de la fontaine?',
  description_it: 'Ritieni che gli schizzi della fontana siano piacevoli?',
  question_group: group,
  answer_possibilities: [unangenehm, mittel, neutral, einigermassen_gut, total_geil]
)
second_question = Question.create!(
  description: 'Ist der Brunnen ästhetisch?',
  question_group: group,
  answer_possibilities: [yes, no]
)

philipps_entry_but_is_anonymous = SurveyEntry.create!(survey: survey)

Answer.create!(
  [
    {
      survey_entry: philipps_entry_but_is_anonymous,
      answer_possibility: yes,
      question: second_question
    }
  ]
)
