# frozen_string_literal: true

require 'httparty'

class LinkShortenService
  include HTTParty
  base_uri 'https://api-ssl.bitly.com'

  def shorten(url)
    result_link = self.class.post('/v4/bitlinks', body: { long_url: url }.to_json,
                                                  headers: { 'Content-Type': 'application/json',
                                                             'Authorization': 'Bearer ' + ENV['BITLY_ACCESS_TOKEN'] },
                                                  format: :json).parsed_response['link']

    return url if result_link.nil?

    result_link
  end
end
