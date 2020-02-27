# frozen_string_literal: true

require 'httparty'

class UrlShortenService
  include HTTParty
  base_uri 'https://api-ssl.bitly.com'

  def shorten(url)
    result_url = self.class.post('/v4/bitlinks', post_options(url)).parsed_response['link']

    result_url || url
  end

  private

  def post_options(url)
    {
      body: { long_url: url }.to_json, format: :json,
      headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer ' + ENV['BITLY_ACCESS_TOKEN'] }
    }
  end
end
