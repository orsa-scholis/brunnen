# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      head :ok
    end
  end

  describe '#set_locale' do
    subject(:locale) { I18n.locale }

    let(:request) { get :index, params: params }
    let(:params) { nil }

    before { request }

    after { I18n.locale = I18n.default_locale }

    it 'renders the page using the default locale' do
      expect(locale).to eq I18n.default_locale
    end

    context 'with a known locale' do
      let(:params) { { locale: 'fr' } }

      it 'sets the locale active' do
        expect(locale).to eq(:fr)
      end
    end

    context 'with an unknown locale' do
      let(:params) { { locale: 'blobby' } }

      it 'falls back to the default locale' do
        expect(locale).to eq I18n.default_locale
      end
    end
  end
end
