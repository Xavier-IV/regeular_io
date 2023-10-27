# frozen_string_literal: true

class AddTypeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :type, :string, null: true
  end
end
