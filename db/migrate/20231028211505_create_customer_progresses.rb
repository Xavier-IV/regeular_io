# frozen_string_literal: true

class CreateCustomerProgresses < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_progresses, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :business, null: false, foreign_key: true, type: :uuid
      t.float :rating_average, null: false, default: 0.0
      t.integer :rating_count, null: false, default: 0
      t.integer :rating_pending, null: false, default: 0
      t.string :level

      t.timestamps
    end
  end
end
