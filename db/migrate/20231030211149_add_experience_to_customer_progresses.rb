# frozen_string_literal: true

class AddExperienceToCustomerProgresses < ActiveRecord::Migration[7.0]
  def change
    add_column :customer_progresses, :experience, :integer, default: 0
  end
end
