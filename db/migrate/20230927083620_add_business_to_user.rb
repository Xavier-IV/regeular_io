# frozen_string_literal: true

class AddBusinessToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :business, null: true, foreign_key: true, type: :uuid
  end
end
