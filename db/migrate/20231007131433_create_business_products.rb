# frozen_string_literal: true

class CreateBusinessProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :business_products, id: :uuid do |t|
      t.string :name
      t.decimal :price
      t.references :business, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
