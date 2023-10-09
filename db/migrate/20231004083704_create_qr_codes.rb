# frozen_string_literal: true

class CreateQrCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :qr_codes, id: :uuid do |t|
      t.string :type
      t.integer :scanned_times, default: 0

      t.timestamps
    end
  end
end
