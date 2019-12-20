# frozen_string_literal: true

class SurveysController < ApplicationController
  def index
    @surveys = (administrator_signed_in? ? Survey.all : Survey.active).order(active_to: :desc)
  end
end
