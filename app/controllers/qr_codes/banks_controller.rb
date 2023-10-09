# frozen_string_literal: true

class QrCodes::BanksController < QrCodesController
  def show
    @business_bank = @qr&.business&.business_bank
  end
end
