# frozen_string_literal: true

require_relative './seed_data/first_survey'
require_relative './seed_data/second_survey'

Administrator.create!(email: 'admin@orsa-schol.is', password: '123456')
