# frozen_string_literal: true

class Clients::Dashboards::Qrs::BanksController < ApplicationController
  include DashboardLayout

  def show
    @bank_info = current_client.business&.business_bank

    unless @bank_info.present? && current_client.business.qr_code_bank.present?
      return redirect_to new_clients_dashboards_qrs_bank_path
    end

    @qr = current_client.business.qr_code_bank

    path = qr_code_url(reference: @qr.id)
    @preview_path = qr_codes_bank_url(reference: @qr.id)
    qrcode = RQRCode::QRCode.new(path)

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

  def new
    return redirect_to edit_clients_dashboards_qrs_bank_path if current_client.business.business_bank.present?

    @bank_info = current_client.business.build_business_bank
  end

  def create
    @bank_info = current_client.business.create_business_bank(bank_info_params)
    if @bank_info.persisted?
      current_client.business.create_qr_code_bank

      flash[:notice] = 'Bank created.'
      redirect_to clients_dashboards_qrs_bank_path
    else
      flash[:alert] = @bank_info.errors.full_messages.join('. ')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    return redirect_to new_clients_dashboards_qrs_bank_path if current_client.business.business_bank.blank?

    @qr = current_client.business.qr_code_bank

    @preview_path = qr_codes_bank_url(reference: @qr.id)
    @bank_info = current_client.business.business_bank
  end

  def update
    @bank_info = current_client.business.business_bank

    if @bank_info.update(bank_info_params)
      redirect_to clients_dashboards_qrs_bank_path, notice: 'Bank updated.'
    else
      flash[:alert] = @bank_info.errors.full_messages.join('. ')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def bank_info_params
    params.require(:business_bank).permit(:bank_id, :account_number, :full_name)
  end
end
