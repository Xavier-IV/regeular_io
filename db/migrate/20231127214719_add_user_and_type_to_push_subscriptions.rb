# frozen_string_literal: true

class AddUserAndTypeToPushSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_reference :push_subscriptions, :user,
                  foreign_key: true, type: :uuid
    add_column :push_subscriptions, :type, :string

    add_index :push_subscriptions, %i[p256dh auth user_id type],
              unique: true,
              name: 'index_push_subscriptions_on_p256dh_auth_user_id_type'
  end
end
