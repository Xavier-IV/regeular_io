# frozen_string_literal: true

class CreateBusinessTokenConsumptions < ActiveRecord::Migration[7.0]
  def change
    create_table :business_token_consumptions, id: :uuid do |t|
      t.string :kind
      t.references :business, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
