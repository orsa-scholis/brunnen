# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale, :set_content_language_header

  private

  def set_locale
    p I18n.locale
    locale_param = params[:locale]
    I18n.locale = I18n.locale_available?(locale_param.try(:to_sym)) ? locale_param : :de
  end

  def set_content_language_header
    response.headers['Content-Language'] = I18n.available_locales.join(',')
  end
end
