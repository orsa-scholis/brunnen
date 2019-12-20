# frozen_string_literal: true

module SurveyLinkClassHelper
  def self.link_classes(survey)
    classes = 'list-group-item list-group-item-action list-group-item-'
    classes += 'primary' if survey.active?
    classes += 'secondary' unless survey.active?

    classes
  end
end
