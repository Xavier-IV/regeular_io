# frozen_string_literal: true

class AddUserTypeToOmniauths < ActiveRecord::Migration[7.0]
  def up
    add_column :omniauths, :user_type, :string
    add_index :omniauths, %i[provider uid user_id], unique: true
  end

  def down
    remove_column :omniauths, :user_type, :string
    remove_index :omniauths, column: %i[provider uid user_id]
  end
end
