# frozen_string_literal: true

class Survey < ApplicationRecord
  has_many :question_groups, inverse_of: :survey, dependent: :destroy
  has_many :survey_entries, inverse_of: :survey, dependent: :destroy

  validates :active_from, :active_to, :title, presence: true
  validates_datetime :active_from, :active_to
  validates_datetime :active_to, after: :active_from

  translates :title
  globalize_accessors

  scope :active, -> { where('active_from <= ? AND active_to >= ?', Time.zone.now, Time.zone.now) }
  scope :descending, -> { order(active_to: :desc) }

  def active?
    Time.zone.now.in?(active_from..active_to)
  end
end
