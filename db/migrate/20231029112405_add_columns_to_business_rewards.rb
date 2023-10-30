# frozen_string_literal: true

class AddColumnsToBusinessRewards < ActiveRecord::Migration[7.0]
  def change
    change_table :business_rewards, bulk: true do |t|
      t.string :value_type
      t.float :capped_amount
    end
  end
end
