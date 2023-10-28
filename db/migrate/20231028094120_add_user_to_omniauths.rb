# frozen_string_literal: true

class AddUserToOmniauths < ActiveRecord::Migration[7.0]
  def change
    add_reference :omniauths, :user, null: true, foreign_key: true, type: :uuid
  end
end
