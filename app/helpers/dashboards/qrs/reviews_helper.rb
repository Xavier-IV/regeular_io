# frozen_string_literal: true

module Dashboards::Qrs::ReviewsHelper
  def generate_qr(path)
    qrcode = RQRCode::QRCode.new(path)

    qrcode.as_svg(
      color: 'FFFFFF',
      shape_rendering: 'crispEdges',
      standalone: true,
      module_size: 10,
      use_path: true,
      viewbox: true,
      svg_attributes: {
        width: '100%',
        height: '100%'
      }
    )
  end
end
