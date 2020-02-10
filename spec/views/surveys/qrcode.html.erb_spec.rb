# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'surveys/qrcode.html.erb', type: :view do
  subject { rendered }

  let(:survey) { instance_double(Survey, id: 1, title: 'My nice survey', short_url: 'short url') }
  let(:qr_code) { instance_double(QrCodeService, to_svg: 'hi im the svg') }

  before do
    assign(:survey, survey)
    assign(:qr_code, qr_code)
  end

  context 'when administrator is signed in' do
    before do
      sign_in create(:administrator)
      render
    end

    it { is_expected.to include survey.title }
    it { is_expected.to include survey.short_url }
    it { is_expected.to include qr_code.to_svg }
    it { is_expected.to include I18n.t('surveys.qrcode.scan_explanation') }
  end
end
