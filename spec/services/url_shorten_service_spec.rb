# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UrlShortenService, type: :service do
  let(:long_url) { 'https://theurltoshorten.com' }
  let(:bitly_request) do
    [
      '/v4/bitlinks',
      body: { long_url: long_url }.to_json,
      headers: { 'Content-Type': 'application/json',
                 'Authorization': 'Bearer ' + ENV['BITLY_ACCESS_TOKEN'] },
      format: :json
    ]
  end
  let(:bitly_response) { instance_double(HTTParty::Response) }
  let(:short_url) { 'https://theshorturl' }

  let(:perform) { described_class.new.shorten(long_url) }

  before do
    allow(described_class).to receive(:post).and_return(bitly_response)
    allow(ENV).to receive(:[]).with('BITLY_ACCESS_TOKEN').and_return('theaccesstoken')
  end

  context 'when valid url is given' do
    before do
      allow(bitly_response).to receive(:parsed_response).and_return('link' => short_url)
    end

    it 'fetches the short url from bitly api' do
      perform
      expect(described_class).to have_received(:post).with(*bitly_request)
    end

    it 'the returned url is correct' do
      expect(perform).to eq short_url
    end
  end

  context 'when invalid url is given' do
    let(:long_url) { 'http://localhost:3000/surveys/2/dashboard' }

    before do
      allow(bitly_response).to receive(:parsed_response).and_return('error' => 'Invalid URL')
    end

    it 'fetches the short url from bitly api' do
      perform
      expect(described_class).to have_received(:post).with(*bitly_request)
    end

    it 'the returned url is correct' do
      expect(perform).to eq long_url
    end
  end
end
