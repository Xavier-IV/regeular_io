# frozen_string_literal: true

class CreatePushSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :push_subscriptions, id: :uuid do |t|
      t.string :endpoint
      t.string :p256dh
      t.string :auth

      t.timestamps
    end
  end
end
