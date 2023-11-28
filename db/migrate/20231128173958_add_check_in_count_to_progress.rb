# frozen_string_literal: true

class AddCheckInCountToProgress < ActiveRecord::Migration[7.0]
  def change
    add_column :customer_progresses, :check_in_count, :integer, default: 0
  end
end
