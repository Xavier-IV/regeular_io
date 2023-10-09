# frozen_string_literal: true

class CreateBusinessBanks < ActiveRecord::Migration[7.0]
  def change
    create_table :business_banks, id: :uuid do |t|
      t.references :bank, null: false, foreign_key: true, type: :uuid
      t.references :business, null: false, foreign_key: true, type: :uuid
      t.string :full_name
      t.string :account_number

      t.timestamps
    end
  end
end
