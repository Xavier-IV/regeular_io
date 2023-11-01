# frozen_string_literal: true

class CreateBusinessStatistics < ActiveRecord::Migration[7.0]
  def change
    create_table :business_statistics, id: :uuid do |t|
      t.references :business, null: false, foreign_key: true, type: :uuid
      t.integer :total_regular
      t.integer :total_customer
      t.float :regular_rating_average
      t.float :customer_rating_average

      t.timestamps
    end
  end
end
