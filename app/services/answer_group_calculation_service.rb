# frozen_string_literal: true

class AnswerGroupCalculationService
  INNER_QUERY = <<~SQL
    (SELECT AVG(value)
      FROM "answer_possibility_submissions"
      WHERE question_group_id = question_groups.id) "avg"
  SQL

  def initialize(survey)
    @survey = survey
  end

  def calculate
    wrap_results(format_results(query_for_results))
  end

  private

  def query_for_results
    Survey.select('question_groups.id', INNER_QUERY)
          .where(survey_arel_table[:id].eq(@survey.id)).joins(
            join_survey_on_question_group
          )
  end

  def wrap_results(results)
    SurveyStatistics.new(survey: @survey, averages: results)
  end

  def format_results(results)
    results.map { |calculation| [QuestionGroup.find(calculation.id), calculation.avg] }.to_h
  end

  def join_survey_on_question_group
    survey_arel_table.join(question_group_arel_table).on(
      survey_arel_table[:id].eq(question_group_arel_table[:survey_id])
    ).join_sources
  end

  def question_group_arel_table
    @question_group_arel_table ||= QuestionGroup.arel_table
  end

  def survey_arel_table
    @survey_arel_table ||= Survey.arel_table
  end
end
