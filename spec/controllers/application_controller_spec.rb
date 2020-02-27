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

  describe '#set_raven_context' do
    before { allow(Raven).to receive(:extra_context) }

    it 'does not call raven api' do
      get :index
      expect(Raven).not_to have_received :extra_context
    end

    context 'when rails environment is production' do
      before do
        allow(Rails).to receive(:env).and_return('production'.inquiry)
        get :index
      end

      it 'provides extra_context to Raven' do
        expect(Raven).to have_received(:extra_context).with(
          hash_including(params: be_a_kind_of(Hash),
                         url: be_a(String))
        )
      end
    end
  end
end
