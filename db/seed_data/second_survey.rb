# frozen_string_literal: true

survey = Survey.create!(title: 'My second survey', active_to: 1.week.since, active_from: 1.day.ago)
group = QuestionGroup.create!(description: 'Lautstärke', survey: survey)

unangenehm = AnswerPossibility.create!(value: -2, description: 'Viel zu laut')
mittel = AnswerPossibility.create!(value: -1, description: 'Zu laut')
neutral = AnswerPossibility.create!(value: 0, description: 'Erträglich')
einigermassen_gut = AnswerPossibility.create!(value: 1, description: 'Leise')
total_geil = AnswerPossibility.create!(value: 2, description: 'Ziemlich leise')

Question.create!(
  description: 'Empfindest du das die Zisterne als zu laut?',
  description_fr: 'Je francais, oui?',
  description_it: 'Bibedi babedi bupedi?',
  question_group: group,
  answer_possibilities: [unangenehm, mittel, neutral, einigermassen_gut, total_geil]
)

Question.create!(
  description: 'Empfindest du das die Brunnen als zu laut?',
  description_fr: 'Je immernoch francais?',
  description_it: 'Pizza?',
  question_group: group,
  answer_possibilities: [unangenehm, mittel, neutral, einigermassen_gut, total_geil]
)
