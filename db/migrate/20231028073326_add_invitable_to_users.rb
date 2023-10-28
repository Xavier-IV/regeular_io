# frozen_string_literal: true

class AddInvitableToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :invitation_token
      t.datetime :invitation_created_at
      t.datetime :invitation_sent_at
      t.datetime :invitation_accepted_at
      t.integer :invitation_limit
      t.integer :invited_by_id
      t.string :invited_by_type
      t.index :invitation_token, unique: true
    end
  end
end
