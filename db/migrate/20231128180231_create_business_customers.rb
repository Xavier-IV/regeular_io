# frozen_string_literal: true

class CreateBusinessCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :business_customers, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :business, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
