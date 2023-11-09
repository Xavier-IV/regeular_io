# frozen_string_literal: true

class AddStatusToBusinesses < ActiveRecord::Migration[7.0]
  def change
    add_column :businesses, :status, :string, default: 'new'
  end
end
