# frozen_string_literal: true

class AddMinOrderAmountToBusinessRewards < ActiveRecord::Migration[7.0]
  def change
    add_column :business_rewards, :min_order_amount, :float
  end
end
