# frozen_string_literal: true

class CreateBusinessTokenLimits < ActiveRecord::Migration[7.0]
  def change
    create_table :business_token_limits, id: :uuid do |t|
      t.string :kind
      t.integer :limit
      t.string :limit_by
      t.references :business, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
