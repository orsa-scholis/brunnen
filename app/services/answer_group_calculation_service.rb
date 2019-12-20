# frozen_string_literal: true

class AnswerGroupCalculationService
  INNER_QUERY = <<~SQL
    (select avg(answer_possibilities.value)
        from question_groups qg
        join questions on qg.id = questions.question_group_id
        join answers on questions.id = answers.question_id
        join answer_possibilities on answers.answer_possibility_id = answer_possibilities.id
        where qg.id = question_groups.id) "avg"
  SQL

  def initialize(survey)
    @survey = survey
  end

  def calculate
    format_results(
      Survey.select('question_groups.id', INNER_QUERY)
        .where(Survey.arel_table[:id].eq(@survey.id)).joins(
          join_survey_on_question_group
        )
    )
  end

  private

  def format_results(results)
    results.map { |calculation| [QuestionGroup.find(calculation.id), calculation.avg] }.to_h
  end

  def join_survey_on_question_group
    Survey.arel_table.join(QuestionGroup.arel_table).on(
      Survey.arel_table[:id].eq(QuestionGroup.arel_table[:survey_id])
    ).join_sources
  end
end
