# frozen_string_literal: true

class SurveysController < ApplicationController
  def index
    @surveys = Survey.all
  end
end
