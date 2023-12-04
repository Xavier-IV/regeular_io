# frozen_string_literal: true

class CreateRiderEarnings < ActiveRecord::Migration[7.0]
  def change
    create_table :rider_earnings, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :rider_brand, null: false, foreign_key: true, type: :uuid
      t.text :notes
      t.string :kind
      t.decimal :amount, precision: 5, scale: 2
      t.decimal :min_amount, precision: 5, scale: 2
      t.decimal :max_amount, precision: 5, scale: 2
      t.integer :hours_spent
      t.integer :trips_completed

      t.timestamps
    end
  end
end
