# frozen_string_literal: true

class SurveyConsistencyChecker
  def initialize(survey)
    @survey = survey
  end

  def consistency_issues
    condense_inconsistencies(
      question_group_inconsistencies,
      question_inconsistencies,
      answer_possibility_inconsistencies
    )
  end

  private

  def condense_inconsistencies(*inconsistencies)
    inconsistencies.compact
  end

  def question_group_inconsistencies
    return if @survey.question_groups.count.positive?

    I18n.t('surveys.consistency_issues.no_question_groups')
  end

  def question_inconsistencies
    return if empty_question_groups.empty?

    names = empty_question_groups
            .map(&compose_proc(QuestionGroup.method(:find), :description, method(:quote)))
            .to_sentence

    I18n.t('surveys.consistency_issues.empty_question_groups', question_groups: names,
                                                               count: empty_question_groups.length)
  end

  def answer_possibility_inconsistencies
    empty_questions = @survey.survey_consistency_overviews.where(answer_possibilities_count: 0)
    return if empty_questions.empty?

    names = empty_questions.map(&compose_proc(:question, :description, method(:quote))).to_sentence

    I18n.t('surveys.consistency_issues.no_answer_possibilities', questions: names, count: empty_questions.length)
  end

  def empty_question_groups
    return @empty_question_groups if @empty_question_groups

    actual_question_groups = @survey.question_groups.pluck(:id)
    valid_question_groups = @survey.survey_consistency_overviews.distinct.pluck(:question_group_id)

    @empty_question_groups = actual_question_groups - valid_question_groups
  end

  def quote(string)
    "\"#{string}\""
  end

  # noinspection RubyArgCount
  def compose_proc(*methods)
    methods.map { |method| Proc.new(&method) }.reduce(&:>>)
  end
end
