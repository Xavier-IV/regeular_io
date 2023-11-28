# frozen_string_literal: true

class CreateCustomerCheckIns < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_check_ins, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :business, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
