# frozen_string_literal: true

class SurveysController < ApplicationController
  def index
    @surveys = Survey.active
  end
end
