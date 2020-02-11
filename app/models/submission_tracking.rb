# frozen_string_literal: true

require 'base64'
require 'yaml'

class SubmissionTracking
  DELIMITER = ','
  COOKIE_IDENTIFIER = 'submissions'

  attr_accessor :survey_entries

  delegate :<<, to: :survey_entries

  def initialize(survey_entries:)
    @survey_entries = survey_entries || []
  end

  def submitted?(survey)
    survey_entries.one? { |entry| entry.survey == survey }
  end

  def save(cookies)
    cookies[COOKIE_IDENTIFIER] = { value: encode, expires: 1.week.from_now }
  end

  def self.load(cookies)
    tracking = SubmissionTracking.new(survey_entries: [])
    tracking.decode(cookies[COOKIE_IDENTIFIER] || '')
    tracking
  end

  def decode(encoded)
    deserialize(Base64.decode64(encoded))
  end

  private

  def encode
    Base64.encode64 serialize
  end

  def serialize
    survey_entries.map(&:id).join(DELIMITER)
  end

  def deserialize(serialized)
    return if serialized.empty?

    self.survey_entries = SurveyEntry.where(id: serialized.split(DELIMITER).map(&:to_i)).to_a
  end
end
