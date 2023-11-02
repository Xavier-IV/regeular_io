# frozen_string_literal: true

class AddQrCodeIdToCustomerRewards < ActiveRecord::Migration[7.0]
  def change
    add_reference :customer_rewards, :qr_code, null: true, foreign_key: true, type: :uuid
  end
end
