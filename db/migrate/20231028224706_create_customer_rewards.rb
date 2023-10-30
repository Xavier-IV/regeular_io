# frozen_string_literal: true

class CreateCustomerRewards < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_rewards, id: :uuid do |t|
      t.string :kind
      t.float :value
      t.datetime :given_at
      t.datetime :claimed_at
      t.integer :likeness
      t.references :business_reward, null: false, foreign_key: true, type: :uuid
      t.references :business, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
