# frozen_string_literal: true

class AddUniqueConstraintToBusinessBanks < ActiveRecord::Migration[7.0]
  def change
    add_index :business_banks, %i[bank_id account_number], unique: true
  end
end
