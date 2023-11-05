# frozen_string_literal: true

class AddApprovedAtToBusinesses < ActiveRecord::Migration[7.0]
  def change
    add_column :businesses, :approved_at, :timestamp
  end
end
