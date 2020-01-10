# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QrCodeService, type: :service do
  let(:data) { 'Some data used to generate qr code' }

  describe '#to_svg' do
    subject(:perform) { described_class.new(data).to_svg }

    it 'QrCode as_svg called' do
      # rubocop:disable RSpec/AnyInstance
      expect_any_instance_of(RQRCode::Export::SVG).to receive(:as_svg).with(offset: 0, color: '000',
                                                                            shape_rendering: 'crispEdges',
                                                                            module_size: 6, standalone: true)
      # rubocop:enable RSpec/AnyInstance

      described_class.new(data).to_svg
    end
  end
end
