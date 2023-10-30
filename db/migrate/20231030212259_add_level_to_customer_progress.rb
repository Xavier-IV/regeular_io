# frozen_string_literal: true

class AddLevelToCustomerProgress < ActiveRecord::Migration[7.0]
  def change
    add_column :customer_progresses, :level, :integer, default: 0
  end
end
