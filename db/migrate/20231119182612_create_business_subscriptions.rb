# frozen_string_literal: true

class CreateBusinessSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :business_subscriptions, id: :uuid do |t|
      t.string :stripe_subscription_id
      t.references :business, null: false, foreign_key: true, type: :uuid
      t.string :status
      t.string :plan
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
