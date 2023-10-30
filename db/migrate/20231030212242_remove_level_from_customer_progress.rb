# frozen_string_literal: true

class RemoveLevelFromCustomerProgress < ActiveRecord::Migration[7.0]
  def change
    remove_column :customer_progresses, :level, :string
  end
end
