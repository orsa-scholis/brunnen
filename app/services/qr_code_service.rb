# frozen_string_literal: true

require 'rqrcode'

class QrCodeService
  DEFAULT_SVG_OPTIONS = {
    offset: 0,
    color: '000',
    shape_rendering: 'crispEdges',
    module_size: 6,
    standalone: true
  }.freeze

  def initialize(data)
    @qr_code = RQRCode::QRCode.new(data)
  end

  def to_svg(options: {})
    @qr_code.as_svg(DEFAULT_SVG_OPTIONS.merge(options))
  end
end
