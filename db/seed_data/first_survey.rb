# frozen_string_literal: true

survey = Survey.create!(title: 'Weiterbildungskurse 2020', active_to: 1.week.since, active_from: 1.day.ago)
group1 = QuestionGroup.create!(description: 'Organisation, Kursgestaltung und -themen', survey: survey)
group2 = QuestionGroup.create!(description: '1. Kurstag / Referate', survey: survey)
group3 = QuestionGroup.create!(description: '2. Kurstag / Halle 23', survey: survey)
group4 = QuestionGroup.create!(description: 'Campus Sursee', survey: survey)

sehr_gut = AnswerPossibility.create!(value: 6, description: 'Sehr gut')
gut = AnswerPossibility.create!(value: 5, description: 'gut')
genuegend = AnswerPossibility.create!(value: 4, description: 'genügend')
schlecht = AnswerPossibility.create!(value: 3, description: 'schlecht')

Question.create!(
  description: 'Empfang und Betreuung vor Ort',
  description_fr: 'Empfang und Betreuung vor Ort',
  description_it: 'Empfang und Betreuung vor Ort',
  question_group: group1,
  answer_possibilities: [sehr_gut, gut, genuegend, schlecht]
)

Question.create!(
  description: 'Anmeldeprozedere  online  oder Papier',
  description_fr: 'Anmeldeprozedere  online  oder Papier',
  description_it: 'Anmeldeprozedere  online  oder Papier',
  question_group: group1,
  answer_possibilities: [sehr_gut, gut, genuegend, schlecht]
)

Question.create!(
  description: 'Kursbewertungsmöglichkeit neu   online',
  description_fr: 'Kursbewertungsmöglichkeit neu   online',
  description_it: 'Kursbewertungsmöglichkeit neu   online',
  question_group: group1,
  answer_possibilities: [sehr_gut, gut, genuegend, schlecht]
)

Question.create!(
  description: 'Verhältnis Theorie - Praxis',
  description_fr: 'Verhältnis Theorie - Praxis',
  description_it: 'Verhältnis Theorie - Praxis',
  question_group: group1,
  answer_possibilities: [sehr_gut, gut, genuegend, schlecht]
)

Question.create!(
  description: 'Kursordner, -unterlagen',
  description_fr: 'Kursordner, -unterlagen',
  description_it: 'Kursordner, -unterlagen',
  question_group: group1,
  answer_possibilities: [sehr_gut, gut, genuegend, schlecht]
)

Question.create!(
  description: 'News SVGW  ',
  description_fr: 'News SVGW  ',
  description_it: 'News SVGW  ',
  question_group: group2,
  answer_possibilities: [sehr_gut, gut, genuegend, schlecht]
)

Question.create!(
  description: 'Druckprüfung – div. Prüfmethoden',
  description_fr: 'Druckprüfung – div. Prüfmethoden',
  description_it: 'Druckprüfung – div. Prüfmethoden',
  question_group: group2,
  answer_possibilities: [sehr_gut, gut, genuegend, schlecht]
)

Question.create!(
  description: 'Bodenkunde Teil 1 & Teil 2',
  description_fr: 'Bodenkunde Teil 1 & Teil 2',
  description_it: 'Bodenkunde Teil 1 & Teil 2',
  question_group: group2,
  answer_possibilities: [sehr_gut, gut, genuegend, schlecht]
)

Question.create!(
  description: 'Respektvoll & wertschätzend miteinander umgehen',
  description_fr: 'Respektvoll & wertschätzend miteinander umgehen',
  description_it: 'Respektvoll & wertschätzend miteinander umgehen',
  question_group: group2,
  answer_possibilities: [sehr_gut, gut, genuegend, schlecht]
)

Question.create!(
  description: 'Druckprüfung',
  description_fr: 'Druckprüfung',
  description_it: 'Druckprüfung',
  question_group: group3,
  answer_possibilities: [sehr_gut, gut, genuegend, schlecht]
)

Question.create!(
  description: 'Zähler',
  description_fr: 'Zähler',
  description_it: 'Zähler',
  question_group: group3,
  answer_possibilities: [sehr_gut, gut, genuegend, schlecht]
)

Question.create!(
  description: 'Halle 23 – Medientechnische Infrastruktur',
  description_fr: 'Halle 23 – Medientechnische Infrastruktur',
  description_it: 'Halle 23 – Medientechnische Infrastruktur',
  question_group: group3,
  answer_possibilities: [sehr_gut, gut, genuegend, schlecht]
)

Question.create!(
  description: 'Ausstellung  Vorplatz Halle 11',
  description_fr: 'Ausstellung  Vorplatz Halle 11',
  description_it: 'Ausstellung  Vorplatz Halle 11',
  question_group: group3,
  answer_possibilities: [sehr_gut, gut, genuegend, schlecht]
)

Question.create!(
  description: 'Simultanübersetzungen (Kurs 3) deutsch - französisch',
  description_fr: 'Simultanübersetzungen (Kurs 3) deutsch - französisch',
  description_it: 'Simultanübersetzungen (Kurs 3) deutsch - französisch',
  question_group: group3,
  answer_possibilities: [sehr_gut, gut, genuegend, schlecht]
)

Question.create!(
  description: 'Simultanübersetzungen (Kurs 3) deutsch - italienisch',
  description_fr: 'Simultanübersetzungen (Kurs 3) deutsch - italienisch',
  description_it: 'Simultanübersetzungen (Kurs 3) deutsch - italienisch',
  question_group: group3,
  answer_possibilities: [sehr_gut, gut, genuegend, schlecht]
)

Question.create!(
  description: 'Verpflegung',
  description_fr: 'Verpflegung',
  description_it: 'Verpflegung',
  question_group: group4,
  answer_possibilities: [sehr_gut, gut, genuegend, schlecht]
)

Question.create!(
  description: 'Räumlichkeiten - Infrastruktur',
  description_fr: 'Räumlichkeiten - Infrastruktur',
  description_it: 'Räumlichkeiten - Infrastruktur',
  question_group: group4,
  answer_possibilities: [sehr_gut, gut, genuegend, schlecht]
)

Question.create!(
  description: 'Falls Sie im Campus übernachtet haben: Unterkunft',
  description_fr: 'Falls Sie im Campus übernachtet haben: Unterkunft',
  description_it: 'Falls Sie im Campus übernachtet haben: Unterkunft',
  question_group: group4,
  answer_possibilities: [sehr_gut, gut, genuegend, schlecht]
)
