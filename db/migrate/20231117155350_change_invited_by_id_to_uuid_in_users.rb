# frozen_string_literal: true

class ChangeInvitedByIdToUuidInUsers < ActiveRecord::Migration[7.0]
  def up
    remove_column :users, :invited_by_id
  end

  def down
    add_column :users, :invited_by_id, :integer
  end
end
