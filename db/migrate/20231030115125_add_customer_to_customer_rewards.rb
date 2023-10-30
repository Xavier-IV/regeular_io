# frozen_string_literal: true

class AddCustomerToCustomerRewards < ActiveRecord::Migration[7.0]
  def change
    change_table :customer_rewards, bulk: true do |t|
      t.references :user, null: true, foreign_key: true, type: :uuid
      t.string :value_type
      t.float :min_order_amount
      t.float :capped_amount
    end
  end
end
