SELECT surveys.id AS "survey_id",
       qg.id      AS "question_group_id",
       q.id       AS "question_id",
       (
           SELECT COUNT(ap.id) ap
           FROM questions
                    LEFT JOIN answer_possibilities_questions apq ON questions.id = apq.question_id
                    LEFT JOIN answer_possibilities ap ON apq.answer_possibility_id = ap.id
           WHERE questions.id = q.id
       )          AS "answer_possibilities_count"
FROM surveys
         INNER JOIN question_groups qg ON surveys.id = qg.survey_id
         INNER JOIN questions q ON qg.id = q.question_group_id
GROUP BY surveys.id, qg.id, q.id;
