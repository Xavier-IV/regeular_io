# frozen_string_literal: true

class AddBusinessIdToQrCode < ActiveRecord::Migration[7.0]
  def change
    add_reference :qr_codes, :business, null: true, foreign_key: true, type: :uuid
  end
end
