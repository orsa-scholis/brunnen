# frozen_string_literal: true

class AnswerGroupCalculationService
  def initialize(survey)
    @survey = survey
  end

  def calculate
    SurveyStatistics.new(survey: @survey, averages: averaged_submissions)
  end

  private

  def averaged_submissions
    @survey.answer_possibility_submissions
           .group(QuestionGroup.arel_table[:id])
           .average(:value)
           .map(&method(:format_result))
           .to_h
  end

  def format_result(question_group_id, average)
    [QuestionGroup.find(question_group_id), average]
  end
end
