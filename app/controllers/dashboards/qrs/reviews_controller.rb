# frozen_string_literal: true

class Dashboards::Qrs::ReviewsController < DashboardsController
  def index
    @qr = (current_user.business.qr_code_review.presence || current_user.business.create_qr_code_review)

    @path = qr_code_url(reference: @qr.id)
    qrcode = RQRCode::QRCode.new(@path)

    @svg = qrcode.as_svg(
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

  def new; end

  def show; end

  def edit; end
end
