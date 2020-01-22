SELECT answer_possibilities.id as "answer_possibility_id",
       answer_possibilities.value,
       qg.id as "question_group_id"
FROM question_groups qg
         JOIN questions ON qg.id = questions.question_group_id
         JOIN answers ON questions.id = answers.question_id
         JOIN answer_possibilities ON answers.answer_possibility_id = answer_possibilities.id
ORDER BY question_group_id
