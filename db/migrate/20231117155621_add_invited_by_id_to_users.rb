# frozen_string_literal: true

class AddInvitedByIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :invited_by_id, :uuid
  end
end
