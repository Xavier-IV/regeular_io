# frozen_string_literal: true

class AddWorkingTimeToBusinesses < ActiveRecord::Migration[7.0]
  def change
    change_table :businesses, bulk: true do |t|
      t.time :open_at
      t.time :close_at
    end
  end
end
